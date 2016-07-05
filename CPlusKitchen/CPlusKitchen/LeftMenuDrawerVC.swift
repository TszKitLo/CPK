//
//  LeftMenuDrawerVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 4/7/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit
import Material
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LeftMenuDrawerVC: UIViewController {
    
    let titles: [String] = ["Search", "Home", "History", "Payment", "Profile", "Settings", "FAQ", "Invite Friends", "Be a Chef"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.frame = CGRectMake(20, (self.view.frame.size.height - 95 * 5) / 2.0, self.view.frame.size.width, 100 * 5)
        tableView.autoresizingMask = [.FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleWidth]
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.opaque = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.backgroundView = nil
        tableView.bounces = false
        return tableView
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor.clearColor()
        view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


// MARK : TableViewDataSource & Delegate Methods

extension LeftMenuDrawerVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
//        let titles: [String] = ["Home", "Calendar", "Profile", "Settings", "Log Out"]
        
//        let images: [String] = ["IconHome", "IconCalendar", "IconProfile", "IconSettings", "IconEmpty"]
        
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel?.text  = titles[indexPath.row]
        cell.selectionStyle = .None
//        cell.imageView?.image = UIImage(named: images[indexPath.row])
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: SearchVC())
            sideMenuViewController?.instantiateView("SearchViewController")
            sideMenuViewController?.hideMenuViewController()
            break
            
        case 1:
            
            sideMenuViewController?.contentViewController = UINavigationController(rootViewController: HomeVC())
            sideMenuViewController?.instantiateView("HomeViewController")
            sideMenuViewController?.hideMenuViewController()
            break

        default:
            break
        }
        
        
    }
    
}