//
//  ViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/17/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

/**
 {"Search":[{"Title":"The Grim Game","Year":"1919","imdbID":"tt0010195","Type":"movie","Poster":"http://ia.media-imdb.com/images/M/MV5BMTg3OTg0MDUwNV5BMl5BanBnXkFtZTgwMjQyNzM2MzE@._V1_SX300.jpg"},{"Title":"Jurassic Park: The Game","Year":"2011","imdbID":"tt1988671","Type":"game","Poster":"N/A"},{"Title":"Prem Kaa Game","Year":"2010","imdbID":"tt1610418","Type":"movie","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BYmYyYWNhZmItMWE4Ny00MTcxLTlkMjAtN2QzYWVmZWVmYjJhXkEyXkFqcGdeQXVyMTExNDQ2MTI@._V1_SX300.jpg"},{"Title":"Goodbye Bruce Lee: His Last Game of Death","Year":"1975","imdbID":"tt0073061","Type":"movie","Poster":"http://ia.media-imdb.com/images/M/MV5BNDg4MDA0NjM2N15BMl5BanBnXkFtZTcwMjI1MTQyMQ@@._V1_SX300.jpg"},{"Title":"The Apple Game","Year":"1977","imdbID":"tt0074652","Type":"movie","Poster":"http://ia.media-imdb.com/images/M/MV5BNjg5MDg4ODU0OV5BMl5BanBnXkFtZTgwNjkxMDE2MTE@._V1_SX300.jpg"},{"Title":"America's Game: The Superbowl Champions","Year":"2006–2011","imdbID":"tt1213209","Type":"series","Poster":"http://ia.media-imdb.com/images/M/MV5BMTU3MjQ4ODc3Nl5BMl5BanBnXkFtZTcwOTY5MTk2MQ@@._V1_SX300.jpg"},{"Title":"The Game: Documentary","Year":"2005","imdbID":"tt0471178","Type":"movie","Poster":"http://ia.media-imdb.com/images/M/MV5BMTk4NzE4MDgyN15BMl5BanBnXkFtZTcwMjA4NDE5MQ@@._V1_SX300.jpg"},{"Title":"The Numbers Game","Year":"2013–","imdbID":"tt2803212","Type":"series","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMjA4Mjc4MjQ5M15BMl5BanBnXkFtZTgwODY5ODAxMzE@._V1_SX300.jpg"},{"Title":"Toy Story 3: The Video Game","Year":"2010","imdbID":"tt1623789","Type":"game","Poster":"N/A"},{"Title":"Match Game PM","Year":"1975–1981","imdbID":"tt0072541","Type":"series","Poster":"http://ia.media-imdb.com/images/M/MV5BMTg0Mzc4NzQ4OF5BMl5BanBnXkFtZTcwOTgxNTkzMQ@@._V1_SX300.jpg"}],"totalResults":"3002","Response":"True"}
 
 **/


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movieList: [Movie] = []
    var theImageCache: [UIImage] = []
    //for favourites
    var tableView: UITableView!
    
    var favouritesArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0)){
            self.fetchData("http://www.omdbapi.com/?s=rebecca")
            
            self.cacheImages()
            
            dispatch_async(dispatch_get_main_queue()){
                self.movieCollection.reloadData()
                //self.tableView.reloadData()
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return favouritesArray.count
    
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        /**
         Set Movie image and title of cell in collection view here.
         
         **/
        
        return movieCell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showInfo", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showInfo" {
            let indexPaths = self.movieCollection.indexPathsForSelectedItems()
            let indexPath = indexPaths![0] as NSIndexPath
            
            let infoView = segue.destinationViewController as! MovieInfoViewController
            
            infoView.movieImage = self.movieList[indexPath.row] as! UIImage
            infoView.title = self.movieList[indexPath.row] as? String
            
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        let savedFaves:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        /**
         if(savedFaves.arrayForKey("favourites") == nil){
            return
        }
         **/
        
        //retrieving previous favourites
        
        //if no saved favourites
        if(savedFaves.objectForKey("favourites") == nil){
            
            //make sure to traverse through pages as well
            
            /**
            let rebeccaMovies:String = "http://www.omdbapi.com/?s=rebecca"
            let url = NSURL(string: rebeccaMovies)
            let request = NSURLRequest(URL: url!)
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            let task = session.dataTaskWithRequest (request) {
                (data, response, error) -> Void in
                
                if error == nil{
                    let  = JSON(data: data!)
                    let theTitle = swiftJSON["results"]["title"].arrayValue
                    
                }
                
                
            }
            **/
            return
        }
        
        let savedPrevious = savedFaves.arrayForKey("favourites")
        
        favouritesArray = savedPrevious!
        
    }
    func fetchData (fetchURL: String) {
        let json = getJSON(fetchURL)
        
        for result in json.arrayValue {
            let title = result["Title"].stringValue
            let releasedYear = result["Year"].stringValue
            let posterURL = result["Poster"].stringValue
            let movieType = result["Type"].stringValue
            
            movieList.append(Movie(movieTitle: title, poster: posterURL, released: releasedYear, type: movieType))
            
        }
        print(movieList)
        
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
        
        for item in theData {
            
            let url = NSURL(string: item.url)
            let data = NSData(contentsOfURL: url!)
            let image = UIImage(data: data!)
            
            theImageCache.append(image!)
            
            
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        /**
         Save favourites for next app opening.
         **/
        
        let savedFaves:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        savedFaves.setObject(favouritesArray, forKey: "favourites")
        savedFaves.synchronize()
        
    }
    
}

