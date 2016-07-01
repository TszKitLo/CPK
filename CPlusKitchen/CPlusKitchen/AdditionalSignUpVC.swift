//
//  AdditionalSignUpVC.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 23/6/2016.
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

class AdditionalSignUpVC: UIViewController{
    
    var user = User()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        prepareProfileImg()
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    // MARK: viewDidLoad helper functions
    func prepareProfileImg(){
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderColor = UIColor.themeOrange().CGColor
        profileImage.layer.cornerRadius = 5.0
        
    }
    
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addImageFromAlbum(sender: AnyObject) {
        
    }
    
    @IBAction func addImageFromCamera(sender: AnyObject) {
        
    }
    
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        
        FIRAuth.auth()?.createUserWithEmail(user.email, password: user.password, completion: { AuthUser, err in
            if err != nil{
                print(err)
            }else{
                DataService.instance.createUser(AuthUser!.uid, userObj: self.user.getUserObject()) // need to change to user data
                
                NSUserDefaults.standardUserDefaults().setValue((AuthUser?.uid)!, forKey: USER_ID)
                self.performSegueWithIdentifier("goToHome", sender: nil)
                FIRAuth.auth()?.signInWithEmail(self.user.email, password: self.user.password, completion: { AuthUser, err in
                    
                })
                
            }
        })
        
        
        
        
    }
    
    private func ShowErrAlert(title : String , msg: String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    
    
    
}