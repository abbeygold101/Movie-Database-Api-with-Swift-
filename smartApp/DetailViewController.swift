//
//  DetailViewController.swift
//  smartApp
//
//  Created by Abiodun Olanrewaju on 25/03/16.
//  Copyright © 2016 Abiodun Olanrewaju. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {

    @IBOutlet weak var overViewText: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var poster: UIImageView!
    var selectedMovie : MovieModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = selectedMovie?.title
        overViewText.text = selectedMovie?.overview
        if let movieRate = selectedMovie?.rating,
           let movieDate = selectedMovie?.date
        {
            rateLabel.text = "Rating:  \(movieRate)"
            dateLabel.text = "Released Date:  " + movieDate
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        //fetch the poster by concatenating the url and poster id
        let imgUrlString = "http://image.tmdb.org/t/p/w500" + (selectedMovie?.imageLink)!
        
        let requestImg = NSURL(string: imgUrlString)

        let request = NSURLRequest(URL: requestImg!)
        //Create an NSurlSession
        let session = NSURLSession.sharedSession()
        
        //Create a datatask and pass in the request
        
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                //Now append the image
                self.bgImage.image = UIImage(data: data!)
            })
            
        })
        
        dataTask.resume()

    }
    
}
