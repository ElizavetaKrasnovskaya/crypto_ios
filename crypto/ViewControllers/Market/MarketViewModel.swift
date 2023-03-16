//
//  MarketViewModel.swift
//  crypto
//
//  Created by admin on 26/02/2023.
//

import Foundation

final class MarketViewModel {
    
    static let shared = MarketViewModel()
    
    @Published var newsResult: Results? = nil
    @Published var coins: [CoinEntity]? = nil
    
    private let repository = CryptoRepository.shared
    private var news = [Results]()
    private var timer = Timer()
    private var index = 0
    
    private init () {
        getNews()
        getCoinsFromDatabase()
    }
    
    private func getNews() {
        repository.getTopNews() { news in
            self.news = news
            if self.index >= news.count { return }
            else {
                self.newsResult = news[self.index]
                self.index += 1
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 8, target: self, selector: #selector(setNews), userInfo: nil, repeats: true)
    }
    
    @objc func setNews() {
        if news.count == 0 {
            return
        } else if index > news.count - 1 {
            index = 0
        }
        newsResult = news[index]
        index += 1
    }
    
    func getCoinsFromDatabase() {
        repository.getTopCoin() { coin in
            self.coins = coin
        }
    }
    
    deinit {
        timer.invalidate()
    }
}
