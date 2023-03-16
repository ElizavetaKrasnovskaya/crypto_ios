//
//  DetailsViewController.swift
//  crypto
//
//  Created by admin on 15/03/2023.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {
    
    private let viewModel = DetailsViewModel.shared
    private var bindings = Set<AnyCancellable>()
    private var coin: CoinEntity? = nil {
        didSet {
            print(coin?.fullName)
            if coin != nil {
                setup(with: coin!)
            }
        }
    }
    
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var coinInfoView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var arrow: UILabel!
    @IBOutlet weak var changedValueLabel: UILabel!
    @IBOutlet weak var changePercentageLabel: UILabel!
    @IBOutlet weak var todaysHightLabel: UILabel!
    @IBOutlet weak var openLabel: UILabel!
    @IBOutlet weak var todaysLowLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var supplyLabel: UILabel!
    @IBOutlet weak var proofTypeLabel: UILabel!
    @IBOutlet weak var algorithmLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
    }
    
    private func initView() {
        aboutView.layer.cornerRadius = 8
        coinInfoView.layer.cornerRadius = 8
    }
    
    private func setup(with coin: CoinEntity) {
        nameLabel.text = coin.fullName
        priceLabel.text = coin.price
        if coin.changePercentageDay.contains("-") {
            changePercentageLabel.textColor = UIColor(hexString: "#f0655e")
            arrow.textColor = UIColor(hexString: "#f0655e")
            arrow.text = "▼"
        } else {
            changePercentageLabel.textColor = UIColor(hexString: "#50b12a")
            arrow.textColor = UIColor(hexString: "#50b12a")
            arrow.text = "▲"
        }
        changePercentageLabel.text = coin.changePercentageDay
        changedValueLabel.text = coin.change24Hours
        todaysHightLabel.text = coin.highDay
        todaysLowLabel.text = coin.lowDay
        openLabel.text = coin.openDay
        volumeLabel.text = coin.volumeDay
        marketCapLabel.text = coin.marketCap
        supplyLabel.text = coin.supply
        algorithmLabel.text = coin.algorithm
        proofTypeLabel.text = coin.proofType
    }
    
    private func bindViewModel() {
        viewModel.$coin
            .assign(to: \.coin, on: self)
            .store(in: &bindings)
    }
    
    @IBAction func onBackBtnClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
