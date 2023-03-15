//
//  StorageService.swift
//  crypto
//
//  Created by admin on 25/02/2023.
//

import Foundation

final class StorageService {
    
    static let shared = StorageService()
    private let storage = UserDefaults.standard
    
    var isFirstLaunch: Bool {
        get {
            !storage.bool(forKey: StorageConstants.FIRST_LAUNCH_KEY)
        }
        set {
            storage.set(!newValue, forKey: StorageConstants.FIRST_LAUNCH_KEY)
        }
    }
    
    var isRememberSelected: Bool {
        get {
            storage.bool(forKey: StorageConstants.IS_REMEMBER_SELECTED)
        } set {
            storage.set(newValue, forKey: StorageConstants.IS_REMEMBER_SELECTED)
        }
    }
}
