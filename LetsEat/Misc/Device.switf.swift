//
//  Device.switf.swift
//  LetsEat
//
//  Created by MacGza on 16/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

struct Device {
    static var currentDevice: UIDevice {
        struct Singleton {
            static let device = UIDevice.current
        }
        return Singleton.device
    }
    
    static var isPhone: Bool {
        return currentDevice.userInterfaceIdiom == .phone
    }
    
    static var isPad: Bool {
        return currentDevice.userInterfaceIdiom == .pad
    }
}
