//
//  RestaurantDatailViewController.swift
//  LetsEat
//
//  Created by MacGza on 26/02/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    // Nav Bar
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    
    // Cell One
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    
    // Cell Two
    @IBOutlet weak var lblTableDetails: UILabel!
    
    // Cell Three
    @IBOutlet weak var lblOverallRating: UILabel!
    
    @IBOutlet weak var ratingView: RatingsView!
    
    // Cell Eight
    @IBOutlet weak var lblAddress: UILabel!
    
    // Cell Nine
    @IBOutlet weak var imgMap: UIImageView!
    
    var selectedRestaurant: RestaurantItem?
    let manager = CoreDataManager()
    
    var reviewsViewController: ReviewsViewController?
    var photoReviewsViewController: PhotoReviewsViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showReview.rawValue:
                showReview(segue: segue)
            case Segue.showPhotoFilter.rawValue:
                showPhotoFilter(segue: segue)
            case Segue.embedReviews.rawValue:
                showEmbedReviews(segue: segue)
            case Segue.embedPhotoReviews.rawValue:
                showEmbedPhotoReviews(segue: segue)
            default:
                print("Segue not added")
            }
        }
    }
    
    func reviewsDidSave(in reviewForm: ReviewFormViewController) {
        dismiss(reviewForm: reviewForm)
    }
    
    func photoReviewsDidSave(in photoFilter: PhotoFilterViewController) {
        dismiss(photoFilter: photoFilter)
    }
}

// MARK: Private Extension
private extension RestaurantDetailViewController {
    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) { }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? ReviewFormViewController else {
            return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
        viewController.presentingRestauranDetailVC = self
    }
    
    func showEmbedReviews(segue: UIStoryboardSegue) {
        if let reviewsVC = segue.destination as? ReviewsViewController {
            reviewsVC.selectedRestaurantID = selectedRestaurant?.restaurantID
            reviewsViewController = reviewsVC
        }
    }
    
    func dismiss(reviewForm: ReviewFormViewController) {
        reviewForm.dismiss(animated: true){
            DispatchQueue.main.async {
                self.createRating()
                self.ratingView.setNeedsDisplay()
                self.reviewsViewController?.reloadReviews()
            }
        }
    }
  
    func showPhotoFilter(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController, let viewController = navController.topViewController as? PhotoFilterViewController else {
            return
        }
        viewController.selectedRestaurantID = selectedRestaurant?.restaurantID
        viewController.presentingRestauranDetailVC = self
    }
    
    func showEmbedPhotoReviews(segue: UIStoryboardSegue) {
        if let photoReviewsVC = segue.destination as? PhotoReviewsViewController {
            photoReviewsVC.selectedRestaurantID = selectedRestaurant?.restaurantID
            photoReviewsViewController = photoReviewsVC
        }
    }
    
    func dismiss(photoFilter: PhotoFilterViewController) {
        photoFilter.dismiss(animated: true){
            DispatchQueue.main.async {
                self.photoReviewsViewController?.reloadPhotoReviews()
            }
        }
    }
    
    func createRating() {
        ratingView.isEnabled = false
        if let id = selectedRestaurant?.restaurantID {
            let value = manager.fetchRestaurantRating(by: id)
            ratingView.rating = CGFloat(value)
            if value.isNaN {
                lblOverallRating.text = "0.0"
            } else {
                let roundedValue = ((value * 10).rounded() / 10)
                lblOverallRating.text = "\(roundedValue)"
            }
        }
    }
    
    func initialize() {
        setupLabels()
        createMap()
        createRating()
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurant else {
            return }
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        if let cuisine = restaurant.subtitle {
            lblCuisine.text = cuisine
        }
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurant,
            let long = annotation.long,
            let lat = annotation.lat else { return }
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapShot(with: location)
    }
    
    func takeSnapShot(with location: CLLocationCoordinate2D) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShotter.start() { snapshot, error in
            guard let snapshot = snapshot else { return }
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width/2
                point.y -= pinView.bounds.size.height/2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
}
