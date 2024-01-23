//
//  Connectivity.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation
import Network

final class Connectivity {
    static let shared = Connectivity()
    
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue.global(qos: .background)
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    var isConnected: Bool {
        return monitor.currentPath.status == .satisfied
    }
}
