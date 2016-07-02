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
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LoginVC: UIViewController,GIDSignInUIDelegate, GIDSignInDelegate {
    
    
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func fbLogin(sender: UIButton!){
        
        
        let facebookLogin = FBSDKLoginManager()
        //logInWithReadPermissions(["email"]) { (facebookResult:FBSDKLoginManagerLoginResult!, facebookErr: NSError!) in
        facebookLogin.logInWithReadPermissions(["public_profile", "email" , "user_friends"], fromViewController: self){(facebookResult: FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
            if (facebookError != nil){
                self.ShowErrAlert("Log In Failed",msg: "Something Wrong!")
                print("log in failed \(facebookError)" )
            }else{
                let credential = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
                FIRAuth.auth()?.signInWithCredential(credential, completion: { AuthUser , err in
                    if err != nil{
                        print(err)
                    }else{
                        
                        //                        let parameters =  ["fields": "id,about,birthday,email,gender,name,picture"]    // get user and user's friend info
                        //                        let parameters2 =  ["fields": "name,picture,gender"]
                        //
                        //                        let fbRequest = FBSDKGraphRequest(graphPath:"me/taggable_friends", parameters: parameters2);
                        //                        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
                        //
                        //                            if error == nil {
                        //                                print("User Info : \(result)")
                        //                            } else {
                        //                                print("Error Getting Info \(error)");
                        //                            }
                        //                        }
                        
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
    
//    func signInWillDispatch(signIn: GIDSignIn!, error: NSError!) {
//        //myActivityIndicator.stopAnimating()
//    }
//    
//    // Present a view that prompts the user to sign in with Google
//    func signIn(signIn: GIDSignIn!,
//                presentViewController viewController: UIViewController!) {
//        self.presentViewController(viewController, animated: true, completion: nil)
//    }
//    
//    // Dismiss the "Sign in with Google" view
//    func signIn(signIn: GIDSignIn!,
//                dismissViewController viewController: UIViewController!) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }

    
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if (error == nil) {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                         accessToken: authentication.accessToken)
            
            FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                // ...
            }
            // ...

            
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
    
    private func ShowErrAlert(title : String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
