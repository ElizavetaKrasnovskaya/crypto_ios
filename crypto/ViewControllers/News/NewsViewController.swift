//
//  NewsViewController.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import UIKit
import Combine

class NewsViewController: UIViewController {

    private let viewModel = NewsViewModel.shared
    private var bindings = Set<AnyCancellable>()
    private var news: [CryptoData]? = nil {
        didSet {
            newsTableView.reloadData()
        }
    }
    
    @IBOutlet weak var newsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
        setupTableView()
    }
    
    private func bindViewModel() {
        viewModel.$news
            .assign(to: \.news, on: self)
            .store(in: &bindings)
    }
    
    private func initView() {
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.barTintColor = UIColor(hexString: "#212B40")
        tabBarController?.tabBar.isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor(hexString: "#212B40")
        tabBarController?.tabBar.backgroundColor = UIColor(hexString: "#212B40")
        newsTableView.layer.cornerRadius = 8
    }
    
    private func setupTableView() {
        newsTableView.register(NewsTableViewCell.nib(), forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
    
    @IBAction func onSearchBtnClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell
        else { return NewsTableViewCell() }
        cell.setup(with: news?[index])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: news?[indexPath.row].url ?? "") {
            UIApplication.shared.open(url)
        }
    }
}
