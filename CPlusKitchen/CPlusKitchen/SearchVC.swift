//
//  SearchVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 5/7/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit

class SearchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareNavBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func prepareNavBar() {
        
        self.title = "Search"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage.init(named: "cm_menu_white"), style: .Plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        
    }
    
    
    
}