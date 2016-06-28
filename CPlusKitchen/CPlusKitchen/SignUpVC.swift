//
//  SignUpVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 25/4/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit
import Material

class SignUpVC: UIViewController, TextFieldDelegate { // UIImagePickerControllerDelegate
    
    var user = User()
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    
//    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var firstNameField: TextField!
    @IBOutlet weak var lastNameField: TextField!
    @IBOutlet weak var emailField: TextField!
    @IBOutlet weak var passwordField: TextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        prepareLastName()
        prepareFirstName()
        prepareEmail()
        preparePassword()
        
        
    }
    
    // Back to landing view
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    
    func prepareLastName(){
        lastNameField.delegate = self
    }
    
    func prepareFirstName(){
        firstNameField.delegate = self
    }
    
    func prepareEmail(){
        emailField.delegate = self
    }
    
    func preparePassword(){
        passwordField.delegate = self
    }

    // Handle keyboard return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // onClick Next
    @IBAction func next(sender: AnyObject) {
        
        if( lastNameField.text == "" || firstNameField.text == "" || emailField.text == "" || passwordField.text == "" ){
            
            let alert = UIAlertController(title: "Information Required", message: "Please fill in your first name, last name and email", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else if( passwordField.text!.characters.count < 8) {
            
            let alert = UIAlertController(title: "Weak Password", message: "Password must contain at least 8 characters", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            self.performSegueWithIdentifier("toAdditional", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navController = segue.destinationViewController as? UINavigationController {
            if let nextView = navController.viewControllers.first as? AdditionalSignUpVC {
                    user.firstName = firstNameField.text!
                    user.lastName = lastNameField.text!
                    user.email = emailField.text!
                    user.password = passwordField.text!

                    nextView.user = user
            }
        }
        
    }
}