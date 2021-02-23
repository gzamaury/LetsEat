//
//  ExploreDataManager.swift
//  LetsEat
//
//  Created by MacGza on 23/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

class ExploreDataManager {
    fileprivate func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"), let items = NSArray(contentsOfFile: path)
            else {
                return [[:]]
        }
        return items as! [[String: AnyObject]]
    }
}
