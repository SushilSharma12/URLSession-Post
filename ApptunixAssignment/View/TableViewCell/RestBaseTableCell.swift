//
//  RestBaseTableCell.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 25/07/20.
//  Copyright © 2020 com. All rights reserved.
//

import UIKit

class RestBaseTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewAllTapped: UIButton!
    @IBOutlet weak var sectionName: UILabel!
    var collectionItems: Int = 0
    
    var categories: [RestCategories]? {
        didSet{
            sectionName.text = "Category"
            self.updateCollectionViewData(count: categories?.count ?? 0)
        }
    }
    
    var bestOffer: [BestOffer]? {
        didSet{
            sectionName.text = "Best Offers"
            self.updateCollectionViewData(count: bestOffer?.count ?? 0)
        }
    }
    
    var saved: [BestOffer]? {
        didSet{
            sectionName.text = "Saved restaurants"
            self.updateCollectionViewData(count: saved?.count ?? 0)
        }
    }
    
    var recommended: [BestOffer]? {
        didSet{
            sectionName.text = "Recommended"
            self.updateCollectionViewData(count: recommended?.count ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib.init(nibName: "RestCategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "restCatCell")
        collectionView.register(UINib.init(nibName: "BestOfferCollectionCell", bundle: nil), forCellWithReuseIdentifier: "restBestOfferCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Updating data in collectionview
    func updateCollectionViewData(count: Int){
        collectionItems = count
        self.collectionView.reloadData()
    }
    
}

//MARK: - CollectionView Delegate and Datasource
extension RestBaseTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restCatCell", for: indexPath) as? RestCategoryCollectionCell
            cell?.setCategoryData(categoryData: categories?[indexPath.row])
            return cell!
        } else if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restBestOfferCell", for: indexPath) as? BestOfferCollectionCell
            cell?.setCategoryData(categoryData: saved?[indexPath.row], isBestOffer: false)
            return cell!
        } else if collectionView.tag == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restBestOfferCell", for: indexPath) as? BestOfferCollectionCell
            cell?.setCategoryData(categoryData: bestOffer?[indexPath.row], isBestOffer: true)
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restBestOfferCell", for: indexPath) as? BestOfferCollectionCell
            cell?.setCategoryData(categoryData: recommended?[indexPath.row], isBestOffer: false)
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize.init(width: UIScreen.main.bounds.width/2.5, height: 150)
        } else {
            return CGSize.init(width: UIScreen.main.bounds.width/2, height: 210)
        }
    }
    
}
