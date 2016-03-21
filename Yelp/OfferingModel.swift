//
//  OfferingModel.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class OfferingModel: NSObject {
        let name: String?
        var onSwitch: Bool
        
        override init() {
            self.name = "Offering"
            self.onSwitch = false
        }
}
