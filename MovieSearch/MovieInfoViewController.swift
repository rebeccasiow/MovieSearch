//
//  MovieInfoViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/18/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {
    
    var movieInfo: Movie!
    var image: UIImage!
    var movieLiked: Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    
    @IBOutlet weak var imdb: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    //Add Movie Title to the faveList global array if not aleady in it.
    //Remove from favourites if not liked anymore
    @IBAction func addToFavourites(sender: UIButton) {
        print("add this movie")
        
        //likeButton.imageView?.image = likeButton.imageView?.highlightedImage
        
        movieLiked = !movieLiked
        
        if (movieLiked == true) {
            likeButton.imageView?.backgroundColor = UIColor.grayColor()
            faveList.insert(movieInfo.movieTitle)
        }
        else if (movieLiked == false) && (faveList.contains(movieInfo.movieTitle)) {
            likeButton.imageView?.backgroundColor = UIColor.clearColor()
            faveList.remove(movieInfo.movieTitle)
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        movieTitleLabel.text = movieInfo.movieTitle
        movieYear.text = movieInfo.released
        typeLabel.text = movieInfo.type
        imdb.text = movieInfo.imdb
        movieLiked = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
