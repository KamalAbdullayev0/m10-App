//
//  NoInternetViewModel.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import Foundation

class NoInternetViewModel {
    var onInternetRestored: (() -> Void)?
    var onShowNoInternetView: (() -> Void)?
    
    func checkInternetConnection() {
        NetworkMonitor.shared.forceCheckConnection { [weak self] isConnected in
            DispatchQueue.main.async {
                if isConnected {
                    self?.onInternetRestored?()
                } else {
                    self?.onShowNoInternetView?()
                }
            }
        }
    }
}
