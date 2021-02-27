//
//  RestaurantDatailViewController.swift
//  LetsEat
//
//  Created by MacGza on 26/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class RestaurantDetailViewController: UITableViewController {
    
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        dump(selectedRestaurant as Any)
    }
}
