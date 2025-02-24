//  NoInternetCoordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import UIKit

final class NoInternetCoordinator {
    private let window: UIWindow
    var onInternetRestored: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = NoInternetViewModel()
        viewModel.onInternetRestored = { [weak self] in
            self?.onInternetRestored?()
        }
        let noInternetViewController = NoInternetView(viewModel: viewModel)
        window.rootViewController = noInternetViewController
        window.makeKeyAndVisible()
    }
}
