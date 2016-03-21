//
//  CategoryModel.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class CategoryModel: NSObject {
    let name: String!
    var onSwitch: Bool!
    
    init(dic: NSDictionary) {
        self.name = dic["alias"] as! String
        self.onSwitch = false
    }
}
