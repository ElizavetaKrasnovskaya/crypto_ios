//
//  CoinTableViewCell.swift
//  crypto
//
//  Created by admin on 26/02/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class CoinTableViewCell: UITableViewCell {
    
    static let identifier = "CoinTableViewCell"
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var exchange: UILabel!
    @IBOutlet weak var volume: UILabel!
    @IBOutlet weak var price: UILabel!
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(with coin: CoinEntity?) {
        name.text = coin?.fullName
        currency.text = "USD"
        exchange.text = coin?.changePercentageDay
        volume.text = coin?.change24Hours
        price.text = coin?.price
        if (coin?.changePercentageDay ?? "").starts(with: "-") {
            exchange.textColor = UIColor(hexString: "#f0655e")
        }
        AF.request(NetworkConstants.IMAGE_URL + (coin?.imageUrl ?? "")).responseImage(completionHandler: { response in
            self.coinImage.image = try? response.result.get()
        })
    }
}
