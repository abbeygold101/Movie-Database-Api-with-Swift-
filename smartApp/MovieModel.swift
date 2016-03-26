//
//  MovieModel.swift
//  smartApp
//
//  Created by Abiodun Olanrewaju on 25/03/16.
//  Copyright © 2016 Abiodun Olanrewaju. All rights reserved.
//

import Foundation

class MovieModel: NSObject {
    // set up properties and methods
    
    var title: String?
    var date: String?
    var rating: Double?
    var overview: String?
    var imageLink: String?
    override init() {
        
    }
  
    init(title: String, date: String, rating: Double, overview: String, imageLink: String) {
        
        self.title = title
        self.date = date
        self.rating = rating
        self.overview = overview
        self.imageLink = imageLink
    }
    
    //prints object's current state
    override var description: String {
        return "Title: \(title), Date: \(date), Overview: \(overview), ImageLink: \(imageLink), Rating: \(rating)"
        
    }
}