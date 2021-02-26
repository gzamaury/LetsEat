//
//  MapViewController.swift
//  LetsEat
//
//  Created by MacGza on 25/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let manager = MapDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize() {
        manager.fetch { (annotations) in addMap(annotations)
        }
    }
    
    func addMap(_ annotations: [RestaurantItem]) {
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
}
