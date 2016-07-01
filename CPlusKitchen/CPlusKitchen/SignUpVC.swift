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
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FBSDKLoginKit
import FBSDKCoreKit

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
            
            ShowErrAlert("Information Required",msg: "Please fill in your first name, last name and email")
            
        } else if( passwordField.text!.characters.count < 8) {
            
            ShowErrAlert("Weak Password",msg: "Password must contain at least 8 characters")
            
        } else {
            self.performSegueWithIdentifier("toAdditional", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toAdditional"{
            if let navController = segue.destinationViewController as? AdditionalSignUpVC {
                    user.firstName = firstNameField.text!
                    user.lastName = lastNameField.text!
                    user.email = emailField.text!
                    user.password = passwordField.text!
                    navController.user = user
                }
            
        }
        
    }
    
    
    
    private func ShowErrAlert(title : String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
}