//
//  CryptoNews.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation

struct CryptoNews: Codable {
    let data: [CryptoData]
}

struct CryptoData: Codable {
    let id: String
    let source: String
    let title: String
    let publishedOn: Int
    let imageUrl: String
    let url: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.source = try container.decode(String.self, forKey: .source)
        self.title = try container.decode(String.self, forKey: .title)
        self.publishedOn = try container.decode(Int.self, forKey: .publishedOn)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.url = try container.decode(String.self, forKey: .url)
    }
}
