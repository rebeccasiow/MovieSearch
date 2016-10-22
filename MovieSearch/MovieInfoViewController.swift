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
    
    @IBOutlet weak var like1: UIButton!
    @IBOutlet weak var like2: UIButton!
    @IBOutlet weak var like3: UIButton!
    @IBOutlet weak var like4: UIButton!
    @IBOutlet weak var like5: UIButton!
    //Add Movie Title to the faveList global array if not aleady in it.
    //Remove from favourites if not liked anymore

    
    @IBAction func ratingsChanged(sender: UIButton) {
        
        switch sender {
        case like1:
            like1.highlighted = true
            like2.highlighted = false
            like3.highlighted = false
            like4.highlighted = false
            like5.highlighted = false
            return
        case like2:
            like1.highlighted = true
            like2.highlighted = true
            like2.highlighted = false
            like3.highlighted = false
            like4.highlighted = false
            like5.highlighted = false
            return
        case like3:
            like1.highlighted = true
            like2.highlighted = true
            like3.highlighted = true
            like4.highlighted = false
            like5.highlighted = false
            return
        case like4:
            like1.highlighted = true
            like2.highlighted = true
            like3.highlighted = true
            like4.highlighted = true
            like5.highlighted = false
            return
        case like5:
            like1.highlighted = true
            like2.highlighted = true
            like3.highlighted = true
            like4.highlighted = true
            like5.highlighted = true
            return
        default:
            return
        }
        
    }
    @IBAction func addToFavourites(sender: UIButton) {
        print("add this movie")
        
        movieLiked = !movieLiked
        
        if (movieLiked == true) {

            likeButton.imageView?.backgroundColor = UIColor.redColor()
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

        like1.setImage(UIImage(named:"starred.png"), forState: .Highlighted)
        like2.setImage(UIImage(named:"starred.png"), forState: .Highlighted)
        like3.setImage(UIImage(named:"starred.png"), forState: .Highlighted)
        like4.setImage(UIImage(named:"starred.png"), forState: .Highlighted)
        like5.setImage(UIImage(named:"starred.png"), forState: .Highlighted)
        
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
