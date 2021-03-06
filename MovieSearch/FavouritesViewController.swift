//
//  FavouritesViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/20/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var faveArray: [String] = Array(faveList)
    
    @IBOutlet weak var favouritesTableList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favouritesTableList.delegate = self
        favouritesTableList.dataSource = self
        faveArray = Array(faveList)
        favouritesTableList.reloadData()
        favouritesTableList.allowsMultipleSelectionDuringEditing = false;

    }
    
    override func viewDidAppear(animated: Bool) {
        print("faveList")
        print(faveList)
        faveArray = Array(faveList)
        print(faveArray)
        favouritesTableList.reloadData()
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            faveList.remove(faveArray[indexPath.row])
            favouritesTableList.reloadData()

            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     Setting up favourites TableView in the favourites tab.
     **/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return faveList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let faveMovie = tableView.dequeueReusableCellWithIdentifier("fave")! as UITableViewCell
        faveMovie.textLabel?.text = faveArray[indexPath.row]

        return faveMovie
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
