//
//  DataService.swift
//  SocialNetwork
//
//  Created by k on 6/29/16.
//  Copyright © 2016 k. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class DataService{
    static let instance = DataService()
    private var _ref = FIRDatabase.database().reference()
    private var _users_ref = FIRDatabase.database().reference().child("users")
    private var _posts_ref = FIRDatabase.database().reference().child("events")


    var ref : FIRDatabaseReference{
        return _ref
    }
    
    var users_ref : FIRDatabaseReference{
        return _users_ref
    }
    
    var posts_ref : FIRDatabaseReference{
        return _posts_ref
    }
    
    
    private init(){
        
    }
    
    func createUser(uid:String, userObj: Dictionary<String,String>){
        _users_ref.child(uid).setValue(userObj)
    }
    
    
    
    
}