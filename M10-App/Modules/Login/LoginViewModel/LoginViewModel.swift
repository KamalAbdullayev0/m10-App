//
//  LoginViewController.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit

final class LoginViewController: UIViewController {
    var onLoginSuccess: (() -> Void)?
    
    private let loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {

      
            print("Fields are empty")
            return
        }
    
}
