//
//  LoginViewController.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit

final class LoginViewModel: UIViewController {
    var onLoginSuccess: (() -> Void)?
    var onLoginFailure: ((String) -> Void)?
    
    func login(email: String, password: String) {
        guard !email.isEmpty, !password.isEmpty else {
            onLoginFailure?("Fields are empty")
            return
        }
        
        let isValid = email == "test@example.com" && password == "password123"
        
        if isValid {
            onLoginSuccess?()
        } else {
            onLoginFailure?("Invalid credentials")
        }
        
    }
}
