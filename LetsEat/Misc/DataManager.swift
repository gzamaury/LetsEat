//
//  DataManager.swift
//  LetsEat
//
//  Created by MacGza on 24/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

protocol DataManager {
    func load(file neme: String) -> [[String: AnyObject]]
}

extension DataManager {
    func load(file name: String) -> [[String: AnyObject]] {
        guard
            let path = Bundle.main.path(forResource: name, ofType: "plist"),
            let items = NSArray(contentsOfFile: path)
            else {
            return [[:]]
        }
        return items as! [[String: AnyObject]]
    }
}
