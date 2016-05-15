//
//  ViewController.swift
//  Instagram
//
//  Created by Hòa Nguyễn Văn on 5/15/16.
//  Copyright © 2016 Hoa.Nguyen. All rights reserved.
//

import UIKit
import AFNetworking

class PhotoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataInstagram: NSArray = [];
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("com.nvh.DemoPrototypeCell", forIndexPath: indexPath) as! DemoPrototypeCell
        if let imagesAttr = dataInstagram[indexPath.row]["images"] {
            if let imageURL = imagesAttr!["standard_resolution"] {
                cell.imageFeed.setImageWithURL(NSURL(string: (imageURL!["url"] as? String)!)!)
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataInstagram.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.cellForRowAtIndexPath(indexPath)?.selectionStyle = UITableViewCellSelectionStyle.None
        NSLog("index path deselected: \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PhotoViewController.refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        tableView.rowHeight = 320
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request, completionHandler: { (dataOrNil, response, error) in
//            if let data = dataOrNil {
//                if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
//                    data, options:NSJSONReadingOptions()) as? NSDictionary {
//                    if let responseData = responseDictionary["data"] {
//                        self.dataInstagram = responseData as! NSArray
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        });
//        task.resume()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PhoneDetailViewController
        let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        vc.photoDict = dataInstagram[indexPath!.row] as! NSDictionary
    }

    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        // ... Create the NSURLRequest (myRequest) ...
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\(clientId)")
        let myRequest = NSURLRequest(URL: url!)

        // Configure session so that completion handler is executed on main UI thread
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(myRequest,
                                                                      completionHandler: { (data, response, error) in
                                                                        if let data = data {
                                                                            if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                                                                                data, options:NSJSONReadingOptions()) as? NSDictionary {
                                                                                if let responseData = responseDictionary["data"] {
                                                                                    self.dataInstagram = responseData as! NSArray
                                                                                    self.tableView.reloadData()
                                                                                    refreshControl.endRefreshing()
                                                                                }
                                                                            }
                                                                        }
                                                                        // Tell the refreshControl to stop spinning
                                                                        
        });
        task.resume()
    }
}

