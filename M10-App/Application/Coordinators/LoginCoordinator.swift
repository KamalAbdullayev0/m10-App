//
//  LoginCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    var onFinish: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let loginViewController = LoginView(viewModel: viewModel)
        loginViewController.onLoginSuccess = { [weak self] in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self?.onFinish?()
        }
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
