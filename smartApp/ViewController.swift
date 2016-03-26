//
//  ViewController.swift
//  smartApp
//
//  Created by Abiodun Olanrewaju on 25/03/16.
//  Copyright © 2016 Abiodun Olanrewaju. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, HomeModelProtocol {
    let homeModel = HomeModel()
    var feedItems: NSArray = NSArray()
    var selectedmovie : MovieModel = MovieModel()
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        homeModel.delegate = self
        homeModel.downloadItems()
    }
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.listTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedItems.count
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Retrieve cell
        let cellIdentifier: String = "BasicCell"
        let myCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        let item: MovieModel = feedItems[indexPath.row] as! MovieModel
        myCell.textLabel!.text = item.title
        return myCell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedmovie = feedItems[indexPath.row] as! MovieModel
        self.performSegueWithIdentifier("goToDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        let detailVC  = segue!.destinationViewController as! DetailViewController
        detailVC.selectedMovie = selectedmovie
    }

}

