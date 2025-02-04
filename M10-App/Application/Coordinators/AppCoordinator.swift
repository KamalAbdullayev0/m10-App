//
//  AppCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?
    private var getStartedCoordinator: GetStartedCoordinator?

    init(window: UIWindow) {
        self.window = window
    }
    func start() {
            isUserLoggedIn() ? showMainFlow() : showGetStartedFlow()
    }
    
    private func showGetStartedFlow() {
        getStartedCoordinator = GetStartedCoordinator(window: window)
        getStartedCoordinator?.start()
    }

    private func showLoginFlow() {
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.start()
    }

    private func showMainFlow() {
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.onLogout = { [weak self] in
            self?.logout()
        }
        mainCoordinator?.start()
    }
    
    
    private func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
    private func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        showLoginFlow()
    }
    
}
