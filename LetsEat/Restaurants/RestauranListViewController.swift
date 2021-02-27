//
//  RestauranListViewController.swift
//  LetsEat
//
//  Created by MacGza on 20/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class RestauranListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


// MARK: Private Extension
private extension RestauranListViewController {
    
}

// MARK: UICollectionViewDataSource
extension RestauranListViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath)
    }
}
