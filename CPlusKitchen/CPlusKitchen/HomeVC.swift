//
//  HomeVC.swift
//  CPlusKitchen
//
//  Created by k on 6/30/16.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import UIKit


class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    /// A tableView used to display Bond entries.
    @IBOutlet weak var tableView: UITableView!

    
    private var events = [Event]()
    
    static let cache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareNavBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.posts_ref.observeEventType(.Value, withBlock: { snapshot in
            
            if let data = snapshot.value as? [String: AnyObject]{
                for snap in data{
                    let eventId = snap.0
                    if let eventData = snap.1 as? [String: AnyObject] {                  
                        self.events.append(Event(id: eventId, data: eventData))
                    }
                }
                
            }
            self.tableView.reloadData()
        })
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let event = events[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as? EventCell{
            
            cell.request?.cancel()

            var img: UIImage?
            
            if let url = event.eventImgURL{
                img = HomeVC.cache.objectForKey(url) as? UIImage
            }
            
            
            cell.configCell(event,img: img)
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //tableView.estimatedRowHeight
        return 80
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func prepareNavBar() {
        
        self.title = "Home"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "cm_menu_white"), style: .Plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "cm_search_white"), style: .Plain, target: self, action: #selector(HomeVC.search))
        
    }

    func search() {
        
    }
    
    
    
}