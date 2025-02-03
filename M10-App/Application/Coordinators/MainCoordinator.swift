//
//  TabbarCoordinator.swift
//  Rent_app
//
//  Created by Kamal Abdullayev on 21.01.25.
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
