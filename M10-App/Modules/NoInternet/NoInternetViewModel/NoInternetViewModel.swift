//
//  NoInternetViewModel.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import Foundation

class NoInternetViewModel {
    private let appCoordinator: AppCoordinator

    init(appCoordinator: AppCoordinator) {
        self.appCoordinator = appCoordinator
    }

    func checkInternetAndRestore() {
        if NetworkMonitor.shared.isConnected {
            appCoordinator.restoreLastFlow()
        }
    }
}
