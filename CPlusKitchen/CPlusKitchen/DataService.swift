//
//  DataService.swift
//  SocialNetwork
//
//  Created by k on 6/29/16.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FBSDKLoginKit

class DataService{
    static let instance = DataService()
    private let _ref = FIRDatabase.database().reference()
    private let _users_ref = FIRDatabase.database().reference().child("users")
    private let _posts_ref = FIRDatabase.database().reference().child("events")
    private let _storageRef = FIRStorage.storage().referenceForURL("gs://cpluskitchen-7a852.appspot.com")
    
    var ref : FIRDatabaseReference{
        return _ref
    }
    
    var users_ref : FIRDatabaseReference{
        return _users_ref
    }
    
    var posts_ref : FIRDatabaseReference{
        return _posts_ref
    }
    
    var storageRef : FIRStorageReference{
        return _storageRef
    }
    
    
    
    
    private init(){
        
    }
    
    func uploadImage(img: UIImage , completion: (String) -> () ){
        
        // need to check if it is a default image later
        let userProfileLocation = _storageRef.child((FIRAuth.auth()?.currentUser?.uid)! + "/profile/profileImage")
        let compressImg = UIImageJPEGRepresentation(img, 0.2)
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = userProfileLocation.putData(compressImg!, metadata: metadata){metadata, error in
            if (error != nil) {
                // Uh-oh, an error occurred!
            } else {
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata!.downloadURL()!.absoluteString  // image url
                completion(downloadURL)
            }
        }
        
        //        uploadTask.observeStatus(.Success) { (snapshot) in
        //
        //            let downloadTxt = snapshot.metadata!.downloadURL()!.absoluteString
        //            print(downloadTxt)
        //        }
        
        
    }
    
    
    
    func createUserWithProvider(provider: String){
        
        var userObj = [String:String]()
        
        
        //        let parameters =  ["fields": "picture,first_name,last_name,email"]    // get user's info
        
        //        let fbRequest = FBSDKGraphRequest(graphPath:"me", parameters: parameters)
        //        fbRequest.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
        //
        //            if error == nil {
        //                if let profile = result as? [String:AnyObject]{
        //
        //                    //print(profile["first_name"])
        //
        //                    userObj["first_name"] =  profile["first_name"] as? String
        //                    userObj["last_name"] =  profile["last_name"] as? String
        //                    userObj["email"] =  profile["email"] as? String
        //                    let picture = profile["picture"] as! [String:AnyObject]
        //                    let data = picture["data"] as! [String:AnyObject]
        //
        //                    userObj["url"] =  data["url"] as? String
        //                    self._users_ref.child(uid).setValue(userObj)
        //
        //
        //                }
        //            } else {
        //                print("Error Getting Info \(error)");
        //            }
        //        }
        //        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
        if let user = FIRAuth.auth()?.currentUser {
            userObj["provider"] = provider
            userObj["name"] = user.displayName
            userObj["email"] = user.email
            userObj["photoURL"] = user.photoURL?.absoluteString
            _users_ref.child(user.uid).updateChildValues(userObj)
            
            
        } else {
            // No user is signed in.
        }
    }
    
    
    func createUser(uid:String, userObj: Dictionary<String,String>){
        _users_ref.child(uid).setValue(userObj)
    }
    
    
    
    
}