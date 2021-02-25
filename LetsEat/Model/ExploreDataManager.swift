//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by MacGza on 23/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

class ExploreDataManager: DataManager {
    
    fileprivate var items: [ExploreItem] = []
    
    func fetch() {
        for data in load(file: "ExploreData") {
            items.append(ExploreItem(dict: data))
        }
    }
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index:IndexPath) -> ExploreItem {
        return items[index.item]
    }
}
