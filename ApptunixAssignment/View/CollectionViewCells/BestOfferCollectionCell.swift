//
//  BestOfferCollectionCell.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 24/07/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

class BestOfferCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var outletSize: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryImage.layer.cornerRadius = 8
        // Initialization code
    }
    
    func setCategoryData(categoryData: BestOffer?, isBestOffer: Bool) {
        guard let category = categoryData else {
            return
        }
        
        categoriesLabel.text = isBestOffer ? category.bestOfferDescription : category.categories.map({$0.name}).joined(separator: ",")
        categoriesLabel.textColor = isBestOffer ? UIColor.red : .black
        categoryName.text = "\(category.name)"
        ratingLabel.text = "\(category.ratings)(\(category.ratingCount))"
        timeLabel.text = "\(category.avgDeliveryTime) MIN"
        outletSize.text = "\(category.outletSize)"
        categoryImage.kf.setImage(with: URL(string: API.baseUrl + category.image), placeholder: nil, options: nil, progressBlock: nil) { (result) in
        }
    }
}
