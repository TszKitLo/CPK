//
//  LoginVC.swift
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

class LoginVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func fbLogin(sender: UIButton!){
        let facebookLogin = FBSDKLoginManager()
        //logInWithReadPermissions(["email"]) { (facebookResult:FBSDKLoginManagerLoginResult!, facebookErr: NSError!) in
        facebookLogin.logInWithReadPermissions(["email"], fromViewController: self){(facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if (facebookError != nil){
                self.ShowErrAlert("Log In Failed",msg: "Something Wrong!")
                print("log in failed \(facebookError)" )
            }else{
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { AuthUser , err in
                    if err != nil{
                        print(err)
                    }else{
                        DataService.instance.createUser(AuthUser!.uid, userObj: ["provider":"facebook","url":"www.google.com"]) // next step :need to load user information
                        NSUserDefaults.standardUserDefaults().setValue((AuthUser?.uid)!, forKey: USER_ID)
                        self.performSegueWithIdentifier("goToHome", sender: nil)
                        
                    }
                })
                
            }
            
            
        }
    }
    
    // login with email
    
//    @IBAction func emailLogin(sender: UIButton!){
//        if let email = emailText.text where email != "", let password = passwordText.text where password != ""{
//            FIRAuth.auth()?.signInWithEmail(email, password: password, completion: { AuthUser, err in
//                if let error = err{
//                    print(error.code)
//                    if error.code  == USER_NOT_CREATED{
//                        self.ShowErrAlert("Log In Failed",msg: "User Not Found")
//                        
//                    }else if error.code == USER_PASSWORD_INCORRECT{
//                        self.ShowErrAlert("Log In Failed",msg: "Incorrect Password")
//                    }
//                    
//                }else{
//                    NSUserDefaults.standardUserDefaults().setValue((AuthUser?.uid)!, forKey: USER_ID)
//                    self.performSegueWithIdentifier("goToHome", sender: nil)
//                }
//                
//            })
//        }
//    }
//    
    
  
    
    private func ShowErrAlert(title : String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }

    
    
    
    
}
