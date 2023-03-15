//
//  CryptoRepository.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation
import CoreData

class CryptoRepository {
    
    static let shared = CryptoRepository()
    private let isFirstLaunch = StorageService.shared.isFirstLaunch
    private let networkService = NetworkService.shared
    private let databaseService = DatabaseService.shared

    private init() {}
    
    func getTopCoin(completion: @escaping([CoinEntity]) -> Void) {
        if isFirstLaunch {
            networkService.getTopCoinWithLimit(completion: { coins in
                self.addCoinsToDatabase(coins: coins, completion: completion)
            }, limit: 10)
            StorageService.shared.isFirstLaunch = false
        } else {
            completion(databaseService.getCoins())
        }
    }
    
    func getCoinsList(completion: @escaping([CoinEntity]) -> Void, page: Int) {
        networkService.getTopCoinWithPage(completion: { coins in
            var result = [CoinEntity]()
            let coinsFromDatabase = self.databaseService.getCoins()
            coins?.data.forEach { coin in
                var isFavourite = false
                for coinFromDatabase in coinsFromDatabase {
                    if coin.coinInfo.id == coinFromDatabase.id {
                        isFavourite = true
                        break
                    }
                }
                result.append(coin.convertToCoinEntity(isFavourite: isFavourite))
            }
            completion(result)
        }, page: page)
    }
    
    func getTopNews(completion: @escaping([Results]) -> Void) {
        networkService.getNews() { news in
            completion(news?.results ?? [Results]())
        }
    }
    
    func getTopNewsArticle(completion: @escaping([CryptoData]) -> Void) {
        networkService.getTopNewsArticle() { news in
            completion(news?.data ?? [CryptoData]())
        }
    }
    
    func addToFavourite(coin: CoinEntity) {
        databaseService.saveCoin(coin: coin)
    }
    
    func removeFromFavourite(id: String) {
        databaseService.deleteCoin(id: id)
    }
    
    private func addCoinsToDatabase(coins: Coin?, completion: @escaping([CoinEntity]) -> Void) {
        var coinsResult = [CoinEntity]()
        coins?.data.forEach { coin in
            databaseService.saveCoin(coin: coin.convertToCoinEntity(isFavourite: true))
            coinsResult.append(coin.convertToCoinEntity(isFavourite: true))
        }
        completion(coinsResult)
    }
}
