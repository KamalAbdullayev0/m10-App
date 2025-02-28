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
        viewModel.onLoginSuccess = { [weak self] in
            self?.onFinish?()
        }
        let loginViewController = LoginView(viewModel: viewModel)
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
