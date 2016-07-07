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
import Firebase


protocol EventCellDelegate{
    func likeButtonPressed(eventID:String,likes:String, completionHandler: (Bool)-> () ) -> Void
    func didUserLikedBefore(eventID:String, completionHandler: (Bool)-> () ) -> Void

}


class EventCell: UITableViewCell {
    
    @IBOutlet weak var eventImg: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventLikes: UILabel!
    @IBOutlet weak var heartImage: UIImageView!
    
    private var eventID: String!
    var eventCellDelegate : EventCellDelegate!
    
    
    var request : Alamofire.Request? = nil
    
    func likeTapped() {
       eventCellDelegate.likeButtonPressed(eventID,likes: eventLikes.text!, completionHandler: LikeButtonUpdate)
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EventCell.likeTapped))
        tap.numberOfTapsRequired = 1
        heartImage.addGestureRecognizer(tap)
        heartImage.userInteractionEnabled = true
        
        
    }

    
    
    
    
    func LikeButtonUpdate(liked : Bool){
        if liked{
            heartImage.image = UIImage(named: "heart-full")
        }else{
            heartImage.image = UIImage(named: "heart-empty")
        }
    }
    
    
    func configCell(event: Event, img: UIImage?){
        
        
        eventTitle.text = event.eventTitle
        eventLikes.text = event.eventLikes
        eventID = event.eventID
        
       // currentUserLikesRef = DataService.instance.users_ref.child((FIRAuth.auth()?.currentUser?.uid)!+"/likes/"+eventID)

        
        if let url = event.eventImgURL{
            if img != nil{
                eventImg.image = img
            }else{
                request = Alamofire.request(.GET, url).responseImage { response in
                    if let image = response.result.value{
                        self.eventImg.image = image
                        HomeVC.cache.setObject(image, forKey: url)
                    }
                }
            }
            
        }else{
            eventImg.hidden = true
        }
        
        eventCellDelegate.didUserLikedBefore(eventID, completionHandler: LikeButtonUpdate)
        
    }
    
    
}
