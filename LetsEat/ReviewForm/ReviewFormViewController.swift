//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by MacGza on 05/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    @IBAction func onSaveTapped(_ sender: Any) {
        print(ratingView.rating)
        print(tfTitle.text as Any)
        print(tfName.text as Any)
        print(tvReview.text as Any)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
