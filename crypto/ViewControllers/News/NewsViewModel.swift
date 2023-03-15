//
//  NewsViewModel.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation

class NewsViewModel {
    
    static let shared = NewsViewModel()
    
    @Published var news: [CryptoData]? = nil
    
    private let repository = CryptoRepository.shared
    
    private init() {
        getCryptoNews()
    }
    
    private func getCryptoNews() {
        repository.getTopNewsArticle() { news in
            self.news = news
        }
    }
}
