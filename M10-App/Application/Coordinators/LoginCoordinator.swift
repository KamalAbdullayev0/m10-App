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
        print("🚀 LoginCoordinator стартовал")
        let viewModel = LoginViewModel()
        viewModel.onLoginSuccess = { [weak self] in
            print("✅ Успешный вход, LoginCoordinator завершает работу")
            self?.onFinish?()
        }
        let loginViewController = LoginView(viewModel: viewModel)
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
        print("📌 LoginView установлен как rootViewController")
    }
}
