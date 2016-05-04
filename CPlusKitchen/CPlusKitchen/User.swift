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
    
    var lastName: String
    var firstName: String
    var email: String
    var password: String
    var icon: NSData
    
    init(){
        self.lastName = ""
        self.firstName = ""
        self.email = ""
        self.password = ""
        self.icon = UIImagePNGRepresentation(UIImage(named: "defaultUser")!)!
    }
    
    
}
