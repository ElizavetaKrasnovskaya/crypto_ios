import Foundation
import Alamofire

// TODO add handling error
final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func getNews(completion: @escaping(News?) -> Void) {
        let url = "https://cryptopanic.com/api/posts/?auth_token=3a2fa52e4249f54aa1d693336b9484ad21e3ccd1"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let newsResponse = try? JSONDecoder().decode(News.self, from: response.data ?? Foundation.Data()) else { return }
                completion(newsResponse)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getTopNewsArticle(completion: @escaping(CryptoNews?) -> Void) {
        let url = "https://min-api.cryptocompare.com/data/v2/news/?&api_key=bdbcf5260f0eb3a57e30f04ef89ecd9076302af9ce083b5a8a06672716de8e3b"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let newsResponse = try? JSONDecoder().decode(CryptoNews.self, from: response.data ?? Foundation.Data()) else { return }
                completion(newsResponse)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getTopCoinWithLimit(completion: @escaping(Coin?) -> Void, limit: Int) {
        let url = "https://min-api.cryptocompare.com/data/top/totalvolfull?tsym=USD&limit=\(limit)&api_key=bdbcf5260f0eb3a57e30f04ef89ecd9076302af9ce083b5a8a06672716de8e3b"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let coinResponse = try? JSONDecoder().decode(Coin.self, from: response.data ?? Foundation.Data()) else { return }
                print(coinResponse)
                completion(coinResponse)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    func getTopCoinWithPage(completion: @escaping(Coin?) -> Void, page: Int) {
        let url = "https://min-api.cryptocompare.com/data/top/totalvolfull?tsym=USD&page=\(page)&api_key=bdbcf5260f0eb3a57e30f04ef89ecd9076302af9ce083b5a8a06672716de8e3b"
        AF.request(url).responseJSON { response in
            switch response.result {
            case .success(_):
                guard let coinResponse = try? JSONDecoder().decode(Coin.self, from: response.data ?? Foundation.Data()) else { return }
                print(coinResponse)
                completion(coinResponse)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
