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
    private var noInternetCoordinator: NoInternetCoordinator?
    
    private var lastCoordinator: AnyObject?
    
    init(window: UIWindow) {
        self.window = window
        NotificationCenter.default.addObserver(self, selector: #selector(didDetectNoInternet), name: .noInternetDetected, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        hasValidToken() ? showMainFlow() : showGetStartedFlow()
    }
    
    private func showGetStartedFlow() {
        getStartedCoordinator = GetStartedCoordinator(window: window)
        lastCoordinator = getStartedCoordinator
        getStartedCoordinator?.onFinish = { [weak self] in
            self?.showLoginFlow()
        }
        getStartedCoordinator?.start()
    }
    
    private func showLoginFlow() {
        loginCoordinator = LoginCoordinator(window: window)
        lastCoordinator = loginCoordinator
        loginCoordinator?.start()
    }
    
    private func showMainFlow() {
        mainCoordinator = MainCoordinator(window: window)
        lastCoordinator = loginCoordinator
        mainCoordinator?.onLogout = { [weak self] in
            self?.logout()
        }
        mainCoordinator?.start()
    }
    
    private func hasValidToken() -> Bool {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        let refreshToken = UserDefaults.standard.string(forKey: "refreshToken")
        return accessToken != nil || refreshToken != nil
    }
    
    private func logout() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        showGetStartedFlow()
    }
    
    @objc private func didDetectNoInternet() {
        noInternetCoordinator = NoInternetCoordinator(window: window)
        noInternetCoordinator?.onInternetRestored = { [weak self] in
                        self?.didRestoreInternet()
                    }
        noInternetCoordinator?.start()
    }

    @objc private func didRestoreInternet() {
           noInternetCoordinator = nil
           guard let lastCoordinator = lastCoordinator else {
               showMainFlow()
               return
           }
           switch lastCoordinator {
           case let coordinator as LoginCoordinator:
               coordinator.start()
           case let coordinator as GetStartedCoordinator:
               coordinator.start()
           case let coordinator as MainCoordinator:
               coordinator.start()
           default:
               showMainFlow()
           }
       }
}
