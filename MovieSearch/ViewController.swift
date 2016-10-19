//
//  ViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/17/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var movieCollection: UICollectionView!
    
    var favouritesArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let movieCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MovieCollectionViewCell
        
        /**
         Set Movie image and title of cell in collection view here.
         
         **/
        
        
        return movieCell
        
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("showImage", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        let savedFaves:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        /**
         if(savedFaves.arrayForKey("favourites") == nil){
            return
        }
         **/
        
        //retrieving previous favourites
        
        if(savedFaves.objectForKey("favourites") == nil){
            return
        }
        
        let savedPrevious = savedFaves.arrayForKey("favourites")
        
        favouritesArray = savedPrevious!
        
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

