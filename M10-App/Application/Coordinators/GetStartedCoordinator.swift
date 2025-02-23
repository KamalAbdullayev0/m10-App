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
        let viewModel = GetStartedViewModel()
        viewModel.onGetStarted = { [weak self] in
            self?.onFinish?()
        }
        let getStartedViewController = GetStartedView(viewModel: viewModel)
        window.rootViewController = getStartedViewController
        window.makeKeyAndVisible()
    }
}
