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
        homeViewController.coordinator = self

        window.rootViewController = homeViewController
        window.makeKeyAndVisible()
    }
    func showProfile() {
            let profileViewModel = ProfileViewModel()
            profileViewModel.onLogout = { [weak self] in
                self?.handleLogout()
            }
            let profileViewController = ProfileViewController(viewModel: profileViewModel)
            profileViewController.modalPresentationStyle = .overFullScreen
            
            // Present the profile screen
            if let rootViewController = window.rootViewController {
                rootViewController.present(profileViewController, animated: true, completion: nil)
            }
        }
        
    private func handleLogout() {
        onLogout?()
    }
}
