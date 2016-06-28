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

class AdditionalSignUpVC: UIViewController{
    
    var user = User()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
    }
    
    @IBAction func addImageFromCamera(sender: AnyObject) {
        
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
    }
}