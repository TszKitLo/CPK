//
//  EventCell.swift
//  CPlusKitchen
//
//  Created by k on 7/1/16.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLikes: UILabel!
    
    var request : Alamofire.Request? = nil
    
    
    func configCell(event: Event, img: UIImage?){
        eventTitle.text = event.eventTitle
        eventLikes.text = event.eventLikes
        
        
        if let url = event.eventImgURL{
            if img != nil{
                eventImg.image = img
            }else{
                request = Alamofire.request(.GET, url).responseImage { response in
                    if let image = response.result.value{
                        self.eventImg.image = image
                        Home.cache.setObject(image, forKey: url)
                    }
                }
            }
            
        }else{
            eventImg.hidden = true
        }
        
    }
    
    
}
