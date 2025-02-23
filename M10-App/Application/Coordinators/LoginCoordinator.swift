//
//  LoginCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import UIKit

final class LoginCoordinator {
    private let window: UIWindow
    private var mainCoordinator: MainCoordinator?
    var onFinish: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = LoginViewModel()
        let loginViewController = LoginView(viewModel: viewModel)
        loginViewController.onLoginSuccess = { //[weak self] in
            print("✅ Успешный вход! Переход в главный экран")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            print("🔄 Создаем и запускаем MainCoordinator")
            self.mainCoordinator = MainCoordinator(window: self.window /*?? UIWindow()*/)
            self.mainCoordinator?.start()
            self.onFinish?()
        }
        print("🔄 Настройка rootViewController для LoginViewController")
        window.rootViewController = loginViewController
        window.makeKeyAndVisible()
    }
}
