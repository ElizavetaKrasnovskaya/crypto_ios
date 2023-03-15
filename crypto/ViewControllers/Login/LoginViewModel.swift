//
//  LoginViewModel.swift
//  crypto
//
//  Created by admin on 25/02/2023.
//

import Foundation
import GoogleSignIn
import FirebaseAuth

final class LoginViewModel {
    
    static let shared = LoginViewModel()
    
    @Published var email: String = "Email"
    @Published var error: String = ""
    @Published var isRememberSelected = false
    @Published var isLoginEnabled = false
    
    private let googleSignIn = GIDSignIn.sharedInstance
    private let storage = StorageService.shared
    
    private init () {
        checkSignIn()
    }
    
    func signIn(_ controller: UIViewController) {
        let googleConfig = GIDConfiguration(clientID: "246459527664-7qoq53chmr1lqrq885mng01tvg2c3lgb.apps.googleusercontent.com")
        googleSignIn.configuration = googleConfig
        
        googleSignIn.signIn(withPresenting: controller) { result, error in
            if error == nil {
                guard let user = result?.user
                else {
                    self.error = "Something went wrong. Can't find this user."
                    return
                }
                self.email = user.profile?.email ?? ""
                self.isLoginEnabled = true
            } else {
                self.error = error?.localizedDescription ?? ""
            }
        }
    }
    
    func rememberUser(_ value: Bool) {
        storage.isRememberSelected = value
    }
    
    func checkSignIn() {
        googleSignIn.restorePreviousSignIn() { _, _ in }
        isRememberSelected = storage.isRememberSelected && googleSignIn.hasPreviousSignIn()
    }
}
