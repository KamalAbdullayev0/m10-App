//
//  LoginCoordinator.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//
import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    var onFinish: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let loginViewController = LoginViewController()
        loginViewController.onLoginSuccess = { [weak self] in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self?.onFinish?()
//            self?.showMainFlow()
        }
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
    
//    private func showMainFlow() {
//        let mainCoordinator = MainCoordinator(window: window)
//        mainCoordinator.onLogout = { [weak self] in
//            self?.logout()
//        }
//        mainCoordinator.start()
//    }

}
