//
//  RestCategoryCollectionCell.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 24/07/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit
import Kingfisher
class RestCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryImage.layer.cornerRadius = 8
    }

    func setCategoryData(categoryData: RestCategories?) {
        guard let category = categoryData else {
            return
        }
        categoryName.text = "\(category.name)(\(category.restaurants))"
        categoryImage.kf.setImage(with: URL(string: API.baseUrl + category.image), placeholder: nil, options: nil, progressBlock: nil) { (result) in
        }
    }
}
