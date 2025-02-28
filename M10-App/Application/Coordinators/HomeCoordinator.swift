//
//  MainCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import UIKit

final class HomeCoordinator {
    var onLogout: (() -> Void)?
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    func start() {
        let viewModel = HomeViewModel()
        let homeViewController = HomeViewController(viewModel: viewModel)
        
        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
    }
    
    private func handleLogout() {
        onLogout?()
    }
}
