//
//  ExploreItem.swift
//  LetsEat
//
//  Created by MacGza on 23/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

struct ExploreItem {
    var name: String
    var image: String
}

extension ExploreItem {
    init(dict:[String:AnyObject]){
        self.name = dict["name"] as! String
        self.image = dict["image"] as! String
    }
}
