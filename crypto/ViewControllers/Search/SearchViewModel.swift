//
//  SearchViewModel.swift
//  crypto
//
//  Created by admin on 11/03/2023.
//

import Foundation

class SearchViewModel {
    
    static let shared = SearchViewModel()
    @Published var filteredCoins = [CoinEntity]()
    @Published var isLoading = true
    private var coins = [CoinEntity]()
    private var page = 0
    private let repository = CryptoRepository.shared
    
    private init() {
        getCoins()
    }
    
    private func getCoins() {
        if coins.isEmpty {
            isLoading = true
            while page < 10 {
                repository.getCoinsList(completion: { coins in
                    self.coins.append(contentsOf: coins)
                    self.filterCoins(by: "")
                    self.filteredCoins.append(contentsOf: coins)
                }, page: page)
                self.page += 1
            }
            isLoading = false
            page = 0
        }
    }
    
    func filterCoins(by filter: String) {
        filteredCoins.removeAll()
        if filter.isEmpty {
            filteredCoins.append(contentsOf: coins)
        } else {
            filteredCoins.append(contentsOf: coins.filter {
                $0.fullName.localizedCaseInsensitiveContains(filter)
            })
        }
    }
    
    func addToFavourite(coin: CoinEntity) {
        repository.addToFavourite(coin: coin)
        coins.enumerated().forEach { index, coin in
            if coin.id == coin.id {
                coins[index].isFavourite = true
            }
        }
    }
    
    func removeFromFavourite(id: String) {
        repository.removeFromFavourite(id: id)
        coins.enumerated().forEach { index, coin in
            if coin.id == id {
                coins[index].isFavourite = false
            }
        }
    }
}