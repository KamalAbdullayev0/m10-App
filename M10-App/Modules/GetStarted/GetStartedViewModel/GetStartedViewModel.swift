//
//  GetStartedViewModel.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 03.02.25.
//
import Foundation

class GetStartedViewModel {
    private let coordinator: LoginCoordinator

    init(coordinator: LoginCoordinator) {
        self.coordinator = coordinator
    }
    func didTapGetStarted() {
        coordinator.start()
    }
}
