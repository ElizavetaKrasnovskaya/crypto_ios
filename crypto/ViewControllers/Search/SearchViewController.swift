//
//  SearchViewController.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import UIKit
import Combine

class SearchViewController: UIViewController, SearchProtocol {
    
    private let viewModel = SearchViewModel.shared
    private var bindings = Set<AnyCancellable>()
    private var coins: [CoinEntity] = [CoinEntity]() {
        didSet {
            coinTableView.reloadData()
        }
    }
    private var loading = true {
        didSet {
            if loading {
                showLoading()
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.hideLoading()
                }
            }
        }
    }

    @IBOutlet private weak var coinTableView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        bindViewModel()
        setupTableView()
    }
    
    override func viewWillLayoutSubviews() {
        if searchField.text?.isEmpty == true {
            viewModel.filterCoins(by: "")
        }
    }
    
    private func initView() {
        showLoading()
        coinTableView.layer.cornerRadius = 8
        searchField.delegate = self
        searchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchField.text = nil
        searchField.attributedPlaceholder = NSAttributedString(string: "Enter coin name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
    }
    
    private func bindViewModel() {
        viewModel.$filteredCoins
            .assign(to: \.coins, on: self)
            .store(in: &bindings)
        viewModel.$isLoading
            .assign(to: \.loading, on: self)
            .store(in: &bindings)
    }
    
    private func setupTableView() {
        coinTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        coinTableView.delegate = self
        coinTableView.dataSource = self
    }
    
    private func showLoading() {
        loadingView.alpha = 1
        loadingView.isHidden = false
        coinTableView.alpha = 0
        searchField.alpha = 0
        loadingView.startAnimating()
    }
    
    private func hideLoading() {
        loadingView.alpha = 0
        loadingView.isHidden = true
        coinTableView.alpha = 1
        searchField.alpha = 1
        loadingView.stopAnimating()
    }
    
    func addToFavourite(coin: CoinEntity) {
        viewModel.addToFavourite(coin: coin)
    }
    
    func removeFromFavourite(id: String) {
        viewModel.removeFromFavourite(id: id)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        viewModel.filterCoins(by: textField.text ?? "")
    }
    
    @IBAction func onBackBtnClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell
        else { return UITableViewCell() }
        cell.setup(with: coins[index], searchProtocol: self)
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
