//
//  AppCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//

import UIKit


// Protocol usage
final class AppCoordinator {
    
    private let window: UIWindow
    private var loginCoordinator: LoginCoordinator?
    private var homeCoordinator: HomeCoordinator?
    private var getStartedCoordinator: GetStartedCoordinator?
    private var noInternetCoordinator: NoInternetCoordinator?
    
    private var lastCoordinator: AnyObject?
    
    init(window: UIWindow) {
        self.window = window
        NotificationCenter.default.addObserver(
            self, selector: #selector(didDetectNoInternet),
            name: .noInternetDetected, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(handleUserDidLogout),
            name: .userDidLogout, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func start() {
        //        didDetectNoInternet()
        hasValidToken() ? showMainFlow() : showGetStartedFlow() //ternary operator
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
        
        loginCoordinator?.onFinish = { [weak self] in
            self?.showMainFlow()
        }
        loginCoordinator?.start()
    }
    
    private func showMainFlow() {
        homeCoordinator = HomeCoordinator(window: window)
        lastCoordinator = homeCoordinator
        homeCoordinator?.onLogout = { [weak self] in
            self?.logout()
        }
        homeCoordinator?.start()
    }
    
    private func hasValidToken() -> Bool {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken") //USER Deafults class 
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
        case let coordinator as HomeCoordinator:
            coordinator.start()
        default:
            showMainFlow()
        }
    }
    @objc private func handleUserDidLogout() {
        logout()
    }
    
}

extension Notification.Name {
    static let userDidLogout = Notification.Name("userDidLogout")
    static let noInternetDetected = Notification.Name("noInternetDetected")
}
