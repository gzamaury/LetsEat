//
//  PhotoReviewsViewController.swift
//  LetsEat
//
//  Created by MacGza on 11/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class PhotoReviewsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectedRestaurantID: Int?
    let manager = CoreDataManager()
    var data: [RestaurantPhotoItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
    
    func reloadPhotoReviews() {
        checkPhotos()
    }
}


// MARK: Private Extension
private extension PhotoReviewsViewController {
    func initialize() {
        setupCollectionView()
    }
    
    func setupDefaults() {
        checkPhotos()
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView?.collectionViewLayout = flow
    }
    
    func checkPhotos() {
        if let id = selectedRestaurantID {
            if data.count > 0 { data.removeAll() }
            data = manager.fetchPhotos(by: id)
            if data.count > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Photos")
                view.set(desc: "There are currently no photos")
                collectionView.backgroundView = view
            }
            collectionView.reloadData()
        }
    }
}


// MARK: UICollectionViewDataSource
extension PhotoReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let item = data[indexPath.item]
        if let photo = item.photo { cell.set(image: photo)}
        return cell
    }
}


// MARK: UICollectionViewDelegateFlowLayout
extension PhotoReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if data.count == 1 {
            let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 200)
        } else {
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 200)
        }
    }
}
