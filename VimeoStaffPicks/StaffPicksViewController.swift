//
//  StaffPicksViewController.swift
//  VimeoStaffPicks
//
//  Created by Eric Kuhn on 8/2/15.
//  Copyright (c) 2015 Eric Kuhn. All rights reserved.
//

import UIKit

class StaffPicksViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView?
    
    var items: Array<Video> = []
    
    // MARK: View Lifecycle


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Staff Picks"
        
        self.setupTableView()
        
        self.refreshItems()
        
    }
    
    // MARK: Setup
    
    func setupTableView() {
        
        let nib = UINib(nibName: "VideoCell", bundle: nil)
        self.tableView?.registerNib(nib, forCellReuseIdentifier: NSStringFromClass(VideoCell.self))

    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(VideoCell.self)) as! VideoCell
        
        let video = self.items[indexPath.row]
        cell.video = video
        
        return cell
    }
    
    func refreshItems() {
        
        VimeoClient.staffpicks { (videos, error) -> Void in
            
            if let constVideos = videos {
                self.items = constVideos
                
                self.tableView?.reloadData()
        
            }
            else {
                // TODO: alert the user
            }
        }
    }

}
