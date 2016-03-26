//
//  HomeModel.swift
//  smartApp
//
//  Created by Abiodun Olanrewaju on 25/03/16.
//  Copyright © 2016 Abiodun Olanrewaju. All rights reserved.
//

import Foundation
protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, NSURLSessionDataDelegate {
    //properties
    weak var delegate: HomeModelProtocol!
    var data : NSMutableData = NSMutableData()
    //query the Api for Upcoming movies
    let urlPath: String = "https://api.themoviedb.org/3/movie/upcoming?api_key=f6bca46d9968874e925b3d7ee4edfb2e"
    
    func downloadItems() {
        let url: NSURL = NSURL(string: urlPath)!
        var session: NSURLSession!
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTaskWithURL(url)
        task.resume()
    }
    
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data.appendData(data);
    }
    
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("trouble downloading data")
        }else {
            self.parseJSON()
        }
    }
    func parseJSON() {
        var movieElement: NSDictionary = NSDictionary()
        let movies: NSMutableArray = NSMutableArray()

        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
            if let movieData = json["results"] as? [[String: AnyObject]] {
                for(var i = 0; i < movieData.count; i++){
                    movieElement = movieData[i] as NSDictionary

                    let movie = MovieModel()
                    if let title = movieElement["title"] as? String,
                        let rating = movieElement["vote_average"] as? Double,
                        let overview = movieElement["overview"] as? String,
                        let date = movieElement["release_date"] as? String,
                        let poster = movieElement["backdrop_path"] as? String
                    
                    {
                        movie.title = title
                        movie.date = date
                        movie.rating = rating
                        movie.overview = overview
                        movie.imageLink = poster
                    }
                    //make sure non of the value is nil
                    if (movie.title != nil){
                        movies.addObject(movie)
                    }
                }
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate.itemsDownloaded(movies)
                })
            }
        }
        catch {
            print("error serializing JSON: \(error)")
        }

    }
}
