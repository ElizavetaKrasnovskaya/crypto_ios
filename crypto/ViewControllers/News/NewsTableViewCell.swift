//
//  NewsTableViewCell.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import UIKit
import Alamofire
import AlamofireImage

class NewsTableViewCell: UITableViewCell {

    static let identifier = "NewsTableViewCell"

    @IBOutlet weak var newsCover: UIImageView!
    @IBOutlet weak var source: UILabel!
    @IBOutlet weak var headlines: UILabel!
    @IBOutlet weak var timePeriod: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static func nib() -> UINib {
        UINib(nibName: identifier, bundle: nil)
    }
    
    func setup(with news: CryptoData?) {
        source.text = news?.source
        headlines.text = news?.title
        timePeriod.text = convertToDate(value: news?.publishedOn ?? 0)
        AF.request(news?.imageUrl ?? "").responseImage(completionHandler: { response in
            self.newsCover.image = try? response.result.get()
        })
    }
    
    private func convertToDate(value: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let date = Date(timeIntervalSince1970: TimeInterval(value))
        return dateFormatter.string(from: date)
    }
}
