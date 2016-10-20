//
//  MovieInfoViewController.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/18/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    var movieInfo: Movie!
    
    var image: UIImage!
    var name: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        movieTitleLabel.text = name
        movieYear.text = movieInfo.released
        typeLabel.text = movieInfo.type
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
