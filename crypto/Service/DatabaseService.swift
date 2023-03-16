//
//  DatabaseService.swift
//  crypto
//
//  Created by admin on 08/03/2023.
//

import Foundation
import CoreData
import UIKit

class DatabaseService {
    
    static let shared = DatabaseService()
    
    private init() {}
    
    func saveCoin(coin insert: CoinEntity) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Crypto", in: managedContext)!
        let coin = NSManagedObject(entity: entity, insertInto: managedContext)
        
        coin.setValue(insert.id, forKey: "id")
        coin.setValue(insert.fullName, forKey: "fullName")
        coin.setValue(insert.imageUrl, forKey: "imageUrl")
        coin.setValue(insert.price, forKey: "price")
        coin.setValue(insert.changePercentageDay, forKey: "changePercentageDay")
        coin.setValue(insert.change24Hours, forKey: "change24Hours")
        coin.setValue(insert.highDay, forKey: "highDay")
        coin.setValue(insert.lowDay, forKey: "lowDay")
        coin.setValue(insert.openDay, forKey: "openDay")
        coin.setValue(insert.volumeDay, forKey: "volumeDay")
        coin.setValue(insert.marketCap, forKey: "marketCap")
        coin.setValue(insert.supply, forKey: "supply")
        coin.setValue(insert.algorithm, forKey: "algorithm")
        coin.setValue(insert.proofType, forKeyPath: "proofType")
        coin.setValue(insert.isFavourite, forKey: "isFavourite")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Couldn't save coin. \(error), \(error.userInfo)")
        }
    }
    
    func getCoins() -> [CoinEntity] {
        var coins = [CoinEntity]()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return coins }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Crypto")
        do {
            try managedContext.fetch(fetchRequest).forEach { coin in
                coins.append(CoinEntity(
                    id: coin.value(forKey: "id") as? String ?? "",
                    name: coin.value(forKey: "name") as? String ?? "",
                    fullName: coin.value(forKey: "fullName") as? String ?? "",
                    imageUrl: coin.value(forKey: "imageUrl") as? String ?? "",
                    price: coin.value(forKey: "price") as? String ?? "",
                    changePercentageDay: coin.value(forKey: "changePercentageDay") as? String ?? "",
                    change24Hours: coin.value(forKey: "change24Hours") as? String ?? "",
                    highDay: coin.value(forKey: "highDay") as? String ?? "",
                    lowDay: coin.value(forKey: "lowDay") as? String ?? "",
                    openDay: coin.value(forKey: "openDay") as? String ?? "",
                    volumeDay: coin.value(forKey: "volumeDay") as? String ?? "",
                    marketCap: coin.value(forKey: "marketCap") as? String ?? "",
                    supply: coin.value(forKey: "supply") as? String ?? "",
                    proofType: coin.value(forKey: "proofType") as? String ?? "",
                    algorithm: coin.value(forKey: "algorithm") as? String ?? "",
                    isFavourite: coin.value(forKey: "isFavourite") as? Bool ?? true
                ))
            }
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
        return coins
    }
    
    func deleteCoin(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
        else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Crypto")
        do {
            try managedContext.fetch(fetchRequest).forEach { coinFromDatabase in
                if id == coinFromDatabase.value(forKey: "id") as? String ?? "" {
                    try managedContext.delete(coinFromDatabase)
                    try managedContext.save()
                    return
                }
            }
        } catch let error as NSError {
            print("Couldn't delete. \(error), \(error.userInfo)")
        }
    }
}
