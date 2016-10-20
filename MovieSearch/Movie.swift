//
//  Movie.swift
//  MovieSearch
//
//  Created by Rebecca Siow on 10/19/16.
//  Copyright © 2016 Rebecca Siow. All rights reserved.
//

import Foundation
import UIKit
/**
 {"Title":"Game of Thrones","Year":"2011–","Rated":"TV-MA","Released":"17 Apr 2011","Runtime":"56 min","Genre":"Adventure, Drama, Fantasy","Director":"N/A","Writer":"David Benioff, D.B. Weiss","Actors":"Peter Dinklage, Lena Headey, Emilia Clarke, Kit Harington","Plot":"While a civil war brews between several noble families in Westeros, the children of the former rulers of the land attempt to rise to power.","Language":"English","Country":"USA, UK","Awards":"Won 1 Golden Globe. Another 206 wins & 339 nominations.","Poster":"https://images-na.ssl-images-amazon.com/images/M/MV5BMjM5OTQ1MTY5Nl5BMl5BanBnXkFtZTgwMjM3NzMxODE@._V1_SX300.jpg","Metascore":"N/A","imdbRating":"9.5","imdbVotes":"1,064,264","imdbID":"tt0944947","Type":"series","totalSeasons":"8","Response":"True"}
 **/

struct Movie {
    
    var movieTitle = ""
    var poster = ""
    var released = ""
    var type = ""

}