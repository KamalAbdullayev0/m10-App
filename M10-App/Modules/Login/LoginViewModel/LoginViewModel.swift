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

        let email = loginView.emailField.text ?? ""
        let password = loginView.passwordField.text ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {

            print("Fields are empty")
            return
        }
        onLoginSuccess?()
    }
}
