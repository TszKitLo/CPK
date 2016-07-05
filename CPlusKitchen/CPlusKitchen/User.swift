//
//  User.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 26/4/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit


class User {
    
    var lastName = ""
    var firstName = ""
    var email = ""
    var password = ""
    var profilePicURL = ""
    var address = ""
    
    init(){
        
    }
    
    deinit {
        
    }
    
    
    func getUserObject() -> [String:String]{
        
        let userObject = ["name": firstName + " " + lastName , "email" : email , "address": address , "photoURL":profilePicURL]
        
        return userObject
    }
    
    
    
    
}
