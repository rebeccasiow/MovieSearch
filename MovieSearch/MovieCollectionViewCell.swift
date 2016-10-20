//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/18/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    //var movieURL = ""
    
    //var movieTitleString = ""
    
    var image: UIImage!
    var name: String!
}
