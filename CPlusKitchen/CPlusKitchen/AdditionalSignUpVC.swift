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

import FBSDKLoginKit
import FBSDKCoreKit

class AdditionalSignUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var user = User()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self;
        
        prepareProfileImg()
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
        presentViewController(imagePicker,animated: true,completion:nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profileImage.image = image // finishing picking image from album
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func addImageFromCamera(sender: AnyObject) {
        
    }
    
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        
        FIRAuth.auth()?.createUserWithEmail(user.email, password: user.password, completion: { AuthUser, err in
            if err != nil{
                print(err?.localizedDescription)
            }else{
                DataService.instance.uploadImage(self.profileImage.image!, completion: { url in
                    self.user.profilePicURL = url
                    DataService.instance.createUser(AuthUser!.uid, userObj: self.user.getUserObject()) // need to change to user data

                })   // upload image from local
                NSUserDefaults.standardUserDefaults().setValue((AuthUser?.uid)!, forKey: USER_ID)
                FIRAuth.auth()?.signInWithEmail(self.user.email, password: self.user.password, completion: { AuthUser, err in
                    if err != nil{
                        print(err?.localizedDescription)
                    }else{
                        self.performSegueWithIdentifier("goToHome", sender: nil)
                        
                    }
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