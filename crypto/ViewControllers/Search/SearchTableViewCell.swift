//
//  SearchTableViewCell.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var isFavourite: UISwitch!
    
    static let identifier = "SearchTableViewCell"
    
    private var searchProtocol: SearchProtocol? = nil
    private var coin: CoinEntity? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(with coin: CoinEntity?, searchProtocol: SearchProtocol) {
        self.searchProtocol = searchProtocol
        self.coin = coin
        name.text = coin?.name
        fullName.text = coin?.fullName
        isFavourite.isOn = coin?.isFavourite ?? false
        AF.request(NetworkConstants.IMAGE_URL + (coin?.imageUrl ?? "")).responseImage(completionHandler: { response in
            self.coinImage.image = try? response.result.get()
        })
    }
    
    @IBAction func onSwitchClicked(_ sender: UISwitch) {
        if sender.isOn, coin != nil {
            searchProtocol?.addToFavourite(coin: coin!)
        } else {
            searchProtocol?.removeFromFavourite(id: coin?.id ?? "")
        }
    }
}
