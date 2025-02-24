//
//  NetworkMonitor.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    private(set) var isConnected: Bool = false {
        didSet {
            if oldValue != isConnected {
                DispatchQueue.main.async { [weak self] in
                    self?.onNetworkStatusChange?(self?.isConnected ?? false)
                }
            }
        }
    }
    
    private(set) var didReceiveInitialPath: Bool = false
    
    private var initialStatusHandlers: [() -> Void] = []
    
    var onNetworkStatusChange: ((Bool) -> Void)?
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            let newStatus = path.status == .satisfied
            if self.isConnected != newStatus {
                self.isConnected = newStatus            }
            
            if !self.didReceiveInitialPath {
                self.didReceiveInitialPath = true
                DispatchQueue.main.async {
                    self.initialStatusHandlers.forEach { $0() }
                    self.initialStatusHandlers.removeAll()
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    func waitForInitialStatus(completion: @escaping () -> Void) {
        if didReceiveInitialPath {
            completion()
        } else {
            initialStatusHandlers.append(completion)
        }
    }
    func forceCheckConnection(completion: @escaping (Bool) -> Void) {
        let evaluator = NWPathMonitor()
        evaluator.start(queue: DispatchQueue.global(qos: .background))
        evaluator.pathUpdateHandler = { [weak self] path in
            let newStatus = path.status == .satisfied
            DispatchQueue.main.async {
                self?.updateConnectionStatus(newStatus)
                completion(newStatus)
                evaluator.cancel()
            }
        }
    }
    
    private func updateConnectionStatus(_ newStatus: Bool) {
        if isConnected != newStatus {
            isConnected = newStatus
        }
    }
}
