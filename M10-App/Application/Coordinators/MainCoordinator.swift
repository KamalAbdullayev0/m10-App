//
//  MainCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import UIKit

final class MainCoordinator {
    var onLogout: (() -> Void)?
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let tabBarController = TabbarController()
        tabBarController.onLogout = { [weak self] in
                    self?.handleLogout()
        }
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func handleLogout() {
        onLogout?()
    }
}
