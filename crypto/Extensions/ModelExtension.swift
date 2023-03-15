import Foundation

extension Results {
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case source
        case domain
        case slug
        case url
        case createdAt = "created_at"
        case publishedAt = "published_at"
    }
}

extension Coin {
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

extension Data {
    enum CodingKeys: String, CodingKey {
        case coinInfo = "CoinInfo"
        case display = "DISPLAY"
    }
}

extension CoinInfo {
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case fullName = "FullName"
        case imageUrl = "ImageUrl"
    }
}

extension Display {
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}
extension Usd {
    enum CodingKeys: String, CodingKey {
        case price = "PRICE"
        case changePercentageDay = "CHANGEPCTDAY"
        case change24Hours = "CHANGE24HOUR"
    }
}

extension CryptoNews {
    enum CodingKeys: String, CodingKey {
        case data = "Data"
    }
}

extension CryptoData {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case source = "source"
        case title = "title"
        case publishedOn = "published_on"
        case imageUrl = "imageurl"
        case url = "url"
    }
}
