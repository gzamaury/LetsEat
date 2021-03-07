//
//  FilterManager.swift
//  LetsEat
//
//  Created by MacGza on 06/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    func fetch(completionHandler: (_ items: [FilterItem]) -> Swift.Void ) {
        var items: [FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        completionHandler(items)
    }
}
