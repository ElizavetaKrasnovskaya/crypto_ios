//
//  CoinEntity.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation

struct CoinEntity {
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let price: String
    let changePercentageDay: String
    let change24Hours: String
    let highDay: String
    let lowDay: String
    let openDay: String
    let volumeDay: String
    let marketCap: String
    let supply: String
    let proofType: String
    let algorithm: String
    var isFavourite: Bool
}

extension CoinEntity: Equatable {
    static func ==(lhs: CoinEntity, rhs: CoinEntity) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name &&
               lhs.fullName == rhs.fullName &&
               lhs.imageUrl == rhs.imageUrl
    }
}
