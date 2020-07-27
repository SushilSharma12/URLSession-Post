//
//  RestModel.swift
//  ApptunixAssignment
//
//  Created by SUSHIL SHARMA on 27/07/20.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation

// MARK: - Restaurants model
struct RestModel: Codable {
    let response: Response
    let data: RestData?
}

// MARK: - Restaurant Data
struct RestData: Codable {
    let categories: [RestCategories]?
    let saved, bestOffers, recommended: [BestOffer]?
    let notiCount: Int
    
    func getSections() -> Int{
        var sections = 0
        if let count = categories?.count, count > 0 {
            sections += 1
        }
        if let count = saved?.count, count > 0 {
            sections += 1
        }
        if let count = bestOffers?.count, count > 0 {
            sections += 1
        }
        if let count = recommended?.count, count > 0, let hasLaunched = UserDefaults.standard.value(forKey: "hasLaunched") as? Bool, hasLaunched == true {
            sections += 1
        }
        return sections
    }
}

// MARK: - BestOffer
struct BestOffer: Codable {
    let id: String
    let categories: [BestOfferCategory]
    let currency: String?
    let foodType, discount, discountUpto, avgDeliveryTime: Int
    let avgOrderPrice: Int
    let openTime: String
    let closeTime: String
    let status: Int
    let name, image: String
    let outlets: [Outlet]
    let outletSize, isFavourite, ratingCount: Int
    let ratings: Double
    let bestOfferDescription: String?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categories, currency, foodType, discount, discountUpto, avgDeliveryTime, avgOrderPrice, openTime, closeTime, status, name, image, outlets, outletSize, isFavourite, ratingCount, ratings
        case bestOfferDescription = "description"
    }
}


// MARK: - BestOfferCategory
struct BestOfferCategory: Codable {
    let name: String
}


// MARK: - Outlet
struct Outlet: Codable {
    let id, address: String
    let latitude, longitude, distance: Double
    let isSelected: Bool

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case address, latitude, longitude, distance, isSelected
    }
}

// MARK: - Restaurant Categories
struct RestCategories: Codable {
    let id: String
    let name: String
    let image: String
    let restaurants: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, image, restaurants
    }
}

// MARK: - Response
struct Response: Codable {
    let success: Bool
    let message: String
    let isUser, logout: Int
}
