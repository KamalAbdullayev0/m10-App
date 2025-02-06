//
//  NetworkMonitor.swift
//  M10-App
//
//  Created by Kamal Abdullayev on 05.02.25.
//
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    var isConnected: Bool = true {
        didSet {
            DispatchQueue.main.async {
                self.onNetworkStatusChange?(self.isConnected)
            }
        }
    }

    var onNetworkStatusChange: ((Bool) -> Void)?

    private init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
