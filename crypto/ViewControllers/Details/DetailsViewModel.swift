//
//  DetailsViewModel.swift
//  crypto
//
//  Created by admin on 15/03/2023.
//
import Combine

class DetailsViewModel {
    
    static let shared = DetailsViewModel()
    
    @Published var coin: CoinEntity? = nil
    
    private init() {}
}
