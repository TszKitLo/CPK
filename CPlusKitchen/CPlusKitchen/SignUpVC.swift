//
//  SignUpVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 25/4/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit
import MaterialKit

class SignUpVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!

    @IBOutlet weak var clickImage: UIImageView!

    @IBOutlet weak var lastNameField: MKTextField!
    @IBOutlet weak var firstNameField: MKTextField!
    @IBOutlet weak var emailField: MKTextField!
    @IBOutlet weak var passwordField: MKTextField!
    @IBOutlet weak var userIcon: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIcon.image = UIImage(named: "defaultUser.png")
        lastNameField.delegate = self
        firstNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        firstNameField.layer.borderColor = UIColor.clearColor().CGColor
        lastNameField.layer.borderColor = UIColor.clearColor().CGColor
        passwordField.layer.borderColor = UIColor.clearColor().CGColor
        emailField.layer.borderColor = UIColor.clearColor().CGColor
        
    }
    
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
//    let singleTap = UITapGestureRecognizer(target: self, action: Selector("tapDetected"))
//    singleTap.numberOfTapsRequired = 1
//    clickImage.userInteractionEnabled = true
//    clickImage.addGestureRecognizer(singleTap)
    
    func tapDetected() {
        print("Single Tap on imageview")
    }
    
    
    // Handle keyboard return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // onClick sign uo 
    @IBAction func signUpAction(sender: AnyObject) {
        
        if( lastNameField.text == "" || firstNameField.text == "" || emailField.text == "" || passwordField.text == "" ){
            
            let alert = UIAlertController(title: "Information Required", message: "Please fill in your first name, last name and email", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else if( passwordField.text!.characters.count < 8) {
            
            let alert = UIAlertController(title: "Weak Password", message: "Password must contain at least 8 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
        }
    }
}