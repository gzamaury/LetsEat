//
//  ImageFiltering.swift
//  LetsEat
//
//  Created by MacGza on 06/03/21.
//  Copyright © 2021 AmauryGz. All rights reserved.
//

import UIKit
import CoreImage

protocol ImageFiltering {
    func apply(filter: String, originalImage: UIImage) -> UIImage
}

protocol ImageFilteringDelegate: class {
    func filterSelected(item: FilterItem)
}

extension ImageFiltering {
    func apply(filter: String, originalImage: UIImage) -> UIImage {
        let initialCIImage = CIImage(image: originalImage, options: nil)
        let originalOrientation = originalImage.imageOrientation
        guard let ciFilter = CIFilter(name: filter) else {
            print("filter not found")
            return UIImage()
        }
        ciFilter.setValue(initialCIImage, forKey: kCIInputImageKey)
        let context = CIContext()
        let filteredCIImage = (ciFilter.outputImage)!
        let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent)
        return UIImage(cgImage: filteredCGImage!, scale: 1.0, orientation: originalOrientation)
    }
}
