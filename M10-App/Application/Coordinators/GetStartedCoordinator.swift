//
//  GetStartedCordinator.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import UIKit

final class GetStartedCoordinator {
    private let window: UIWindow
    var onFinish: (() -> Void)?
    
    init(window: UIWindow) {
        self.window = window
    }
    

    func start() {
        let loginCoordinator = LoginCoordinator(window: window)
        loginCoordinator.onFinish = { [weak self] in
            self?.onFinish?()
        }
        let viewModel = GetStartedViewModel(coordinator: loginCoordinator)
        let getStartedViewController = GetStartedView(viewModel: viewModel)
        window.rootViewController = getStartedViewController
        window.makeKeyAndVisible()
    }
}
