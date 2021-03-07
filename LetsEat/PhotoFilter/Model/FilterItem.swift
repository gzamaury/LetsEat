//
//  FilterItem.swift
//  LetsEat
//
//  Created by MacGza on 06/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

class FilterItem: NSObject {
    let filter: String
    let name: String
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
