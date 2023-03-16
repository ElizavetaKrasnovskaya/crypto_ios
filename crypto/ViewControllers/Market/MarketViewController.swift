import UIKit
import Combine

class MarketViewController: UIViewController {
    
    private let viewModel = MarketViewModel.shared
    private var bindings = Set<AnyCancellable>()
    private var news: Results? = nil {
        didSet {
            newsLabel.text = news?.title ?? "News"
            newsLabel.center.y += newsLabel.bounds.size.height
            newsLabel.alpha = 0
            UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseOut], animations: {
                self.newsLabel.center.y -= self.newsLabel.bounds.size.height
                self.newsLabel.alpha = 1
            }, completion: nil)
        }
    }
    private var coins: [CoinEntity]? = nil {
        didSet {
            coinTableView.reloadData()
        }
    }
    
    @IBOutlet private weak var addView: UIStackView!
    @IBOutlet private weak var newsLabel: UILabel!
    @IBOutlet private weak var newsView: UIStackView!
    @IBOutlet private weak var coinTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
        setupTableView()
    }
    
    private func initView() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.barTintColor = UIColor(hexString: "#212B40")
        tabBarController?.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(hexString: "#212B40")
        tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#212B40")
        tabBarController?.navigationItem.hidesBackButton = true
        addView.layer.cornerRadius = 30
        addView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openAddCurrency)))
        newsView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openNews)))
    }
    
    private func bindViewModel() {
        viewModel.$newsResult
            .assign(to: \.news, on: self)
            .store(in: &bindings)
        viewModel.$coins
            .assign(to: \.coins, on: self)
            .store(in: &bindings)
    }
    
    private func setupTableView() {
        coinTableView.register(CoinTableViewCell.nib(), forCellReuseIdentifier: CoinTableViewCell.identifier)
        coinTableView.delegate = self
        coinTableView.dataSource = self
    }
    
    @objc private func openAddCurrency() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func openNews() {
        if let url = URL(string: news?.url ?? "https://cryptopanic.com/news/17738336/Heres-What-Co-Founder-of-MakerDAO-Buying-and-Selling") {
            UIApplication.shared.open(url)
        }
    }
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.identifier, for: indexPath) as? CoinTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: coins?[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DetailsViewModel.shared.coin = coins?[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}
