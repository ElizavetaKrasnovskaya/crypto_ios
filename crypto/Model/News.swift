import Foundation

struct News: Codable {
    let count: Int
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let title: String
    let source: Source
    let domain: String
    let createdAt: String
    let slug: String
    let url: String
    let publishedAt: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.publishedAt = try container.decode(String.self, forKey: .publishedAt)
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.source = try container.decode(Source.self, forKey: .source)
        self.domain = try container.decode(String.self, forKey: .domain)
        self.slug = try container.decode(String.self, forKey: .slug)
        self.url = try container.decode(String.self, forKey: .url)
    }
}

struct Source: Codable {
    let title: String
    let domain: String
}
