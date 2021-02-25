//
//  MapDataManager.swift
//  LetsEat
//
//  Created by MacGza on 24/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

class MapDataManager: DataManager {
    fileprivate var items: [RestaurantItem] = []
    
    var annotations: [RestaurantItem] {
        return items
    }
    
    func fetch(completion:(_ annotations: [RestaurantItem]) -> ()) {
        if items.count > 0 { items.removeAll() }
        for data in load(file: "MapLocations") {
            items.append(RestaurantItem(dict: data))
        }
        completion(items)
    }
}
