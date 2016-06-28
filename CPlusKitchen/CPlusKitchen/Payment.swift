//
//  Payment.swift
//  CPlusKitchen
//
//  Created by Keith Lo on 16/6/2016.
//  Copyright © 2016 lotszkit. All rights reserved.
//

import Foundation

class Payment{
    let percent_15 = 0.15
    let percent_18 = 0.18
    let percent_20 = 0.20
//    let chargeWithoutTips: Double
    
//    inti(){
//    
//    }
    
    func tips(people: Int, chargeWithoutTips: Double) -> Double {
        if (people <= 2) {
            return percent_15 * chargeWithoutTips
        } else if (people >= 3 && people <= 4){
            return percent_18 * chargeWithoutTips
        } else if (people >= 5) {
            return percent_20 * chargeWithoutTips
        } else {
            return 0.0
        }
    }
}