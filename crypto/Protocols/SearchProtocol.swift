//
//  SearchProtocol.swift
//  crypto
//
//  Created by admin on 12/03/2023.
//

import Foundation

protocol SearchProtocol {
    func addToFavourite(coin: CoinEntity)
    func removeFromFavourite(id: String)
}
