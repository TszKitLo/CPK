//
//  Home.swift
//  CPlusKitchen
//
//  Created by k on 6/30/16.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import UIKit
import Firebase

class Home: UIViewController,UITableViewDelegate,UITableViewDataSource,EventCellDelegate {
    /// A tableView used to display Bond entries.
    @IBOutlet weak var tableView: UITableView!
    private var currentUserLikesRef : FIRDatabaseReference!
    
    private var events = [Event]()
    
    static let cache = NSCache()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.navigationItem.setHidesBackButton(true, animated: false) // not allow go back to login
        
        tableView.delegate = self
        tableView.dataSource = self
        
        DataService.instance.posts_ref.observeEventType(.Value, withBlock: { snapshot in
            self.events = []
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
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func likeButtonPressed(eventID:String,likes:String, completionHandler: (Bool)-> () ) -> Void{
        var liked  = false
        currentUserLikesRef = DataService.instance.users_ref.child((FIRAuth.auth()?.currentUser?.uid)!+"/likes/"+eventID)
        
        currentUserLikesRef.observeSingleEventOfType(.Value , withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                self.currentUserLikesRef.setValue(true)
                DataService.instance.posts_ref.child(eventID).updateChildValues(["likes": Int(likes)!+1])
                liked = true
            }else{
                self.currentUserLikesRef.removeValue()
                DataService.instance.posts_ref.child(eventID).updateChildValues(["likes": Int(likes)!-1])
                liked = false
            }
            completionHandler(liked)
        })
        
    }
    
    func didUserLikedBefore(eventID:String, completionHandler: (Bool)-> () ) -> Void{
        
        
        var liked  = false
        currentUserLikesRef = DataService.instance.users_ref.child((FIRAuth.auth()?.currentUser?.uid)!+"/likes/"+eventID)
        
        currentUserLikesRef.observeSingleEventOfType(.Value , withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                
                liked = false
            }else{
                
                liked = true
            }
            completionHandler(liked)
        })
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let event = events[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as? EventCell{
            
            cell.request?.cancel()
            
            cell.eventCellDelegate = self
            
            var img: UIImage?
            
            if let url = event.eventImgURL{
                img = Home.cache.objectForKey(url) as? UIImage
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("tapped cell")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    
}