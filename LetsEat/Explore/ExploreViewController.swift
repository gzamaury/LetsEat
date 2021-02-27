//
//  ExploreViewController.swift
//  LetsEat
//
//  Created by MacGza on 19/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let manager = ExploreDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}


// MARK: Private Extension
private extension ExploreViewController {
    
    func initialize() {
        manager.fetch()
    }
    
    @IBAction func unwindLocationCancel(segue:UIStoryboardSegue){
    }
}

// MARK: UICollectionViewDataSource
extension ExploreViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind Kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: Kind, withReuseIdentifier: "header", for: indexPath)
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "exploreCell", for: indexPath) as! ExploreCell
        let item = manager.explore(at: indexPath)
        cell.lblName.text = item.name
        cell.imgExplore.image = UIImage(named: item.image)
        return cell
    }
}
