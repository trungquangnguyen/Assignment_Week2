//
//  DistanceModel.swift
//  Yelp
//
//  Created by nguyen trung quang on 3/20/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SortByModel: NSObject {
    let name: String?
    var isSelect: Bool
    let mode: YelpSortMode
    
    init(name: String, isSelect: Bool, mode: YelpSortMode) {
        self.name = name
        self.isSelect = isSelect
        self.mode = mode
    }
}
