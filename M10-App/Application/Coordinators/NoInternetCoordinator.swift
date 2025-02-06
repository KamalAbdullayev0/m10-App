//
//  NoInternetCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import UIKit

final class NoInternetCoordinator {
    private let window: UIWindow
    private var lastCoordinator: Any?
    
    init(window: UIWindow, lastCoordinator: Any?) {
        self.window = window
        self.lastCoordinator = lastCoordinator
        
        NetworkMonitor.shared.onNetworkStatusChange = { [weak self] isConnected in
            if isConnected {
                self?.restorePreviousFlow()
            }
        }
    }
    
    func start() {
        let viewModel = NoInternetViewModel(appCoordinator: lastCoordinator as! AppCoordinator)
        let noInternetViewController = NoInternetView(viewModel: viewModel)
        
        window.rootViewController = noInternetViewController
        window.makeKeyAndVisible()
        
        Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true) { [weak self] _ in
            self?.checkAndRestore()
        }
    }
    
    private func checkAndRestore() {
        if NetworkMonitor.shared.isConnected {
            restorePreviousFlow()
        }
    }
    
    private func restorePreviousFlow() {
        if let appCoordinator = lastCoordinator as? AppCoordinator {
            appCoordinator.start()
        } else if let mainCoordinator = lastCoordinator as? MainCoordinator {
            mainCoordinator.start()
        } else if let loginCoordinator = lastCoordinator as? LoginCoordinator {
            loginCoordinator.start()
        } else if let getStartedCoordinator = lastCoordinator as? GetStartedCoordinator {
            getStartedCoordinator.start()
        }
    }
}
