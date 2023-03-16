//
//  CoinEntityExtension.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation

extension Data {
    func convertToCoinEntity(isFavourite: Bool) -> CoinEntity {
        return CoinEntity(id: self.coinInfo.id,
                          name: self.coinInfo.name,
                          fullName: self.coinInfo.fullName,
                          imageUrl: self.coinInfo.imageUrl,
                          price: self.display.usd.price,
                          changePercentageDay: self.display.usd.changePercentageDay,
                          change24Hours: self.display.usd.change24Hours,
                          highDay: self.display.usd.highDay,
                          lowDay: self.display.usd.lowDay,
                          openDay: self.display.usd.openDay,
                          volumeDay: self.display.usd.volumeDay,
                          marketCap: self.display.usd.marketCap,
                          supply: self.display.usd.supply,
                          proofType: self.coinInfo.proofType,
                          algorithm: self.coinInfo.algorithm,
                          isFavourite: isFavourite)
    }
}
