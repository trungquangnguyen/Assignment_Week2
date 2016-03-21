//
//  DistanceModel.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class DistanceModel: NSObject {
    let name: String?
    var isSelect: Bool
    let value: Float
    
    init(name: String, isSelect: Bool, value: Float) {
        self.name = name
        self.isSelect = isSelect
        self.value = value
    }
}
