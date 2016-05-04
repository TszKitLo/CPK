//
//  LoginVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 25/4/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
