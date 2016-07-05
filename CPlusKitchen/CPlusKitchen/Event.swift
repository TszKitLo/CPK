//
//  Event.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 16/6/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation
import UIKit


class Event{
    
    //    var date: NSDate;
    private var _eventID : String
    private var _eventTitle : String
    private var _eventImgURL : String?
    private var _eventLikes: String
    
    
    var eventID : String{
        return _eventID
    }
    var eventTitle : String{
        return _eventTitle
        
    }
    var eventImgURL : String?{
        return _eventImgURL    }
    var eventLikes: String{
        return _eventLikes
        
    }
    
    
    
    
    init(id: String, data: [String : AnyObject]){
        //        date = NSDate.
        
        
        let title = data["title"] as! String
        let likes = data["likes"] as! Int
        let imgURL = data["imgURL"] as? String
        
        _eventID = id
        _eventTitle = title
        _eventImgURL = imgURL
        _eventLikes = "\(likes)"
    }
    
    
    func adjustLikes(setLike: Bool){
        if setLike{
            DataService.instance.posts_ref.child(self._eventID + "/likes").setValue(Int(_eventLikes)!+1)
        }else{
            DataService.instance.posts_ref.child(self._eventID + "/likes").setValue(Int(_eventLikes)!-1)
        }
    }
    
}