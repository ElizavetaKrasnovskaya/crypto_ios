import Foundation

struct Coin: Codable {
    
    let data: [Data]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.data = try container.decode([Data].self, forKey: .data)
    }
}

struct Data: Codable {
    
    let coinInfo: CoinInfo
    let display: Display
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coinInfo = try container.decode(CoinInfo.self, forKey: .coinInfo)
        self.display = try container.decode(Display.self, forKey: .display)
    }
}

struct CoinInfo: Codable {
    
    let id: String
    let name: String
    let fullName: String
    let imageUrl: String
    let proofType: String
    let algorithm: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fullName = try container.decode(String.self, forKey: .fullName)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.proofType = try container.decode(String.self, forKey: .proofType)
        self.algorithm = try container.decode(String.self, forKey: .algorithm)
    }
}

struct Display: Codable {
    
    let usd: Usd
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.usd = try container.decode(Usd.self, forKey: .usd)
    }
}

struct Usd: Codable {
    
    let price: String
    let changePercentageDay: String
    let change24Hours: String
    let highDay: String
    let lowDay: String
    let openDay: String
    let volumeDay: String
    let marketCap: String
    let supply: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.price = try container.decode(String.self, forKey: .price)
        self.changePercentageDay = try container.decode(String.self, forKey: .changePercentageDay)
        self.change24Hours = try container.decode(String.self, forKey: .change24Hours)
        self.highDay = try container.decode(String.self, forKey: .highDay)
        self.lowDay = try container.decode(String.self, forKey: .lowDay)
        self.openDay = try container.decode(String.self, forKey: .openDay)
        self.volumeDay = try container.decode(String.self, forKey: .volumeDay)
        self.marketCap = try container.decode(String.self, forKey: .marketCap)
        self.supply = try container.decode(String.self, forKey: .supply)
    }
}
