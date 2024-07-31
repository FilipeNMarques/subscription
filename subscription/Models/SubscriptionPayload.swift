//
//  SubscriptionPayload.swift
//  subscription
//
//  Created by Filipe Marques on 31/07/24.
//

import Foundation

struct SubscriptionPayload: Decodable {
    let id: String
    let record: Record
    let metadata: Metadata

    struct Record: Decodable {
        let header_logo: String
        let subscription: SubscriptionDetails
    }

    struct SubscriptionDetails: Decodable {
        let offer_page_style: String
        let cover_image: String
        let subscribe_title: String
        let subscribe_subtitle: String
        let offers: [String: OfferDetails]
        let benefits: [String]
        let disclaimer: String
    }

    struct OfferDetails: Decodable {
        let price: Double
        let description: String
    }

    struct Metadata: Decodable {
        let name: String
        let readCountRemaining: Int
        let timeToExpire: Int
        let createdAt: String
    }
}
