//
//  AppCoordinator.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        if isUserLoggedIn() {
            showMainFlow()
        } else {
            showLoginFlow()
        }
    }

    private func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }

    private func showLoginFlow() {
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.onFinish = { [weak self] in
            self?.showMainFlow()
        }
        loginCoordinator?.start()
    }

    private func showMainFlow() {
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.onLogout = { [weak self] in
            self?.logout()
        }
        mainCoordinator?.start()
    }

    private func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        showLoginFlow()
    }
}
