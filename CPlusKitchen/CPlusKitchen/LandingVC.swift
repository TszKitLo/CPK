//
//  LandingVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 25/4/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import UIKit

class LandingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButton(sender: AnyObject) {
        self.performSegueWithIdentifier("toLogin", sender: self)
    }

    @IBAction func signUpButton(sender: AnyObject) {
        self.performSegueWithIdentifier("toSignUp", sender: self)
    }
}

