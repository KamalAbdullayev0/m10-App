//
//  AppCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//

import UIKit

final class AppCoordinator: NetworkManagerDelegate {
    private let window: UIWindow
    private var networkManager: NetworkManager!
    private var loginCoordinator: LoginCoordinator?
    private var mainCoordinator: MainCoordinator?
    private var getStartedCoordinator: GetStartedCoordinator?
    private var noInternetCoordinator: NoInternetCoordinator?
    private var lastCoordinator: AnyObject?
    
    init(window: UIWindow) {
        self.window = window
        self.networkManager = NetworkManager()
        self.networkManager.delegate = self
    }
    func start() {
        isUserLoggedIn() ? showMainFlow() : showGetStartedFlow()
    }
    
    private func showGetStartedFlow() {
        lastCoordinator = getStartedCoordinator
        getStartedCoordinator = GetStartedCoordinator(window: window)
        getStartedCoordinator?.start()
    }
    
    private func showLoginFlow() {
        lastCoordinator = loginCoordinator
        loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator?.start()
    }
    
    private func showMainFlow() {
        lastCoordinator = mainCoordinator
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
    
    func didDetectNoInternet() {
        noInternetCoordinator = NoInternetCoordinator(window: window, lastCoordinator: self)
        noInternetCoordinator?.start()
    }
    func restoreLastFlow() {
        func restoreLastFlow() {
            if let lastCoordinator = lastCoordinator {
                if let loginCoordinator = lastCoordinator as? LoginCoordinator {
                    loginCoordinator.start()
                } else if let getStartedCoordinator = lastCoordinator as? GetStartedCoordinator {
                    getStartedCoordinator.start()
                } else if let mainCoordinator = lastCoordinator as? MainCoordinator {
                    mainCoordinator.start()
                }
            }
        }
    }
}
