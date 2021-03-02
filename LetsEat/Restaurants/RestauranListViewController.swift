//
//  RestauranListViewController.swift
//  LetsEat
//
//  Created by MacGza on 20/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class RestauranListViewController: UIViewController, UICollectionViewDelegate {
    
    var selectedRestaruant: RestaurantItem?
    var selectedCity: LocationItem?
    var selectedType: String?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard let location = selectedCity?.city , let type = selectedType else { return }
        print("type \(type)")
        print(RestaurantAPIManager.loadJSON(file: location))
    }
}


// MARK: Private Extension
private extension RestauranListViewController {
    
}

// MARK: UICollectionViewDataSource
extension RestauranListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }
}
