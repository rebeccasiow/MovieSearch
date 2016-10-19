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
    
    var movieImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
