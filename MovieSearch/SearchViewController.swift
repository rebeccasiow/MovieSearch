//
//  ViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/17/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movieList: [Movie] = []
    var theImageCache: [UIImage] = []
    var faveList: [String] = []
    var searchString = ""
    
    @IBOutlet weak var searchBarItem: UISearchBar!
    
    //@IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var noResults: UILabel!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    /**
     ViewDidLoad
     **/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieCollection.delegate = self
        movieCollection.dataSource = self
        searchBarItem.delegate = self
        //searchString = "http://www.omdbapi.com/?s=rebecca"
        searchString = "https://doctor-bjczzz-coreysalzer.c9users.io/getUser"
        log("")
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            self.view.addSubview(self.spinner)
            //self.spinner.hidden = true
            self.spinner.startAnimating()
            
            self.log("dispatch async")
            
            self.fetchData(self.searchString)

            self.log("Started")
            self.cacheImages()
            
            dispatch_async(dispatch_get_main_queue()){
                
                //UI Loaded Here
                self.movieCollection.reloadData()
                
            }
            
            
        }
        
        self.spinner.stopAnimating()
        self.spinner.hidden = true


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func log(logMessage: String, functionName: String = #function) {
        print("\(functionName): \(logMessage)")
    }
    
    
    /**
     Outlets:
     - searchbar
     **/
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        movieList.removeAll()
        movieCollection.reloadData()
        log("searchBar start")
        guard let searchText = searchBar.text else {
            print("search text is nil")
            return
        }
        searchString = searchText
        
        if (searchText.characters.count > 2) {
            log(searchText)
            
            dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
        
                
                self.log("searching main thread")
                self.fetchData("http://www.omdbapi.com/?s=\(self.searchString)")
                //self.cacheImages()
                
                dispatch_async(dispatch_get_main_queue()){
                    
                    //self.spinner.hidden = false
                    self.spinner.startAnimating()
                    self.view.addSubview(self.spinner)

                    self.movieCollection.reloadData()
                    self.spinner.stopAnimating()
                
                }
            }
        }
        else {
            noResults.hidden = false
            log("searchText too short")

        }

    }

    
    /**
     collectionView:
      - numberOfItemsInSection: set the number of sections
      - cellForItemAtIndexPath: set the contents of collectionviewcells
      - didSelectItemAtIndexPath
     
     **/
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let movieCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        movieCell.moviePoster.image = theImageCache[indexPath.row]
        movieCell.movieTitle.text = movieList[indexPath.row].movieTitle
                
        return movieCell
        
    }
    
    /**
     Setting up collectionViewCells - push MovieInfoViewController after clicking on a MovieCollectionViewCell, segue to MovieInfoViewController
     
      - didSelectItemAtIndexPath -> prepareForSegue
     **/
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showInfo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showInfo" {
            let indexPaths = self.movieCollection.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            
            let infoView = segue.destinationViewController as! MovieInfoViewController
            
            infoView.movieInfo = movieList[indexPath.row]
            infoView.image = theImageCache[indexPath.row]
            infoView.title = self.movieList[indexPath.row].movieTitle
        }
    }
    
       
    /**
     LOADING AND SAVING INTO FAVOURITES TABLE
     
     viewWillAppear - what to load when view is loading
         - load the saved things from the last app NSUserDefaults into the favourites array
     viewWillDisappear - what to save when view disappears
         - save things for next app opening into the favourites array
     **/
    
    override func viewWillAppear(animated: Bool) {
        //retrieving previous favourites

        let savedFaves:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        //if no saved favourites
        if(savedFaves.objectForKey("favourites") == nil){
            //make sure to traverse through pages as well
            return
        }
        
        guard let savedPrevious = savedFaves.arrayForKey("favourites") else {
            print("No Favourites")
            return
        }
        let stringsPlease : [String] = savedPrevious as! [String]
        faveList = stringsPlease
        //favouritesArray = savedPrevious!
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        
        /**
         Save favourites for next app opening.
         **/
        
        let savedFaves:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        savedFaves.setObject(faveList, forKey: "favourites")
        savedFaves.synchronize()
        
    }

    
    /**
     Fetching data from the API:
      - fetchData(fetchURL: String):
      - getJSON(url: String)
      - cacheImages
     **/
    
    func fetchData (fetchURL: String) {
        log("start")
        
        let json = getJSON(fetchURL)
        log("does get json work")
        print(json)
        
        movieList.removeAll()
        theImageCache.removeAll()

        //If no results, clear collection view and return
        if(json["Response"].stringValue == "False"){
            noResults.hidden = false
            return
        }
        else {
            noResults.hidden = true
        }
        
        let resultTotal = json["totalResults"].intValue
        let resultPages = resultTotal/10+1
        
        for resultPage in 1..<resultPages {
            let pageURL = fetchURL+"&page=\(resultPage)"
            let pageJSON = getJSON(pageURL)
            
            for result in pageJSON["Search"].arrayValue {

                let title = result["Title"].stringValue
                let releasedYear = result["Year"].stringValue
                let posterURL = result["Poster"].stringValue
                let movieType = result["Type"].stringValue
                let imdbid = result["imdbID"].stringValue

                movieList.append(Movie(movieTitle: title, poster: posterURL, released: releasedYear, type: movieType, imdb: imdbid))
                //self.cacheImage(posterURL)
                
                if(posterURL == "N/A"){
                    log("breaking here")
                    theImageCache.append(UIImage(named:"No-image-found.jpg")!)
                    log("are we getting here")
                }
                else {
                    print("item poster:"+posterURL)
                    
                    let url = NSURL(string: posterURL)
                    guard let data = NSData(contentsOfURL: url!) else {
                        theImageCache.append(UIImage(named:"No-image-found.jpg")!)
                        return
                    }
                    let image = UIImage(data: data)
                    
                    theImageCache.append(image!)
                }


                

            }
        }

        
        //print(movieList)
        
    }
    
    
    private func getJSON(url: String) -> JSON {
        
        if let nsurl = NSURL(string: url){
            if let data = NSData(contentsOfURL: nsurl) {
                let json = JSON(data: data)
                return json
            } else {
                return nil
            }
        } else {
            return nil
        }
        
    }
    
    func cacheImages() {
        
        //NSURL
        //NSData
        //UIImage
        
        for item in movieList {
            
            if(item.poster == "N/A"){
                log("breaking here")
                theImageCache.append(UIImage(named:"No-image-found.jpg")!)
                log("are we getting here")
            }
            else {
                print("item poster:"+item.poster)

                let url = NSURL(string: item.poster)
                guard let data = NSData(contentsOfURL: url!) else {
                    theImageCache.append(UIImage(named:"No-image-found.jpg")!)
                    return
                }
                let image = UIImage(data: data)
                
                theImageCache.append(image!)
            }
        }
        
    }
}

