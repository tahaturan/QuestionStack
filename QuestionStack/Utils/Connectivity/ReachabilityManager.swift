//
//  Connectivity.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation
import Reachability

protocol ReachabilityManagerDelegate: AnyObject {
    func isNetworkReachability(isAvaiable: Bool)
}

class ReachabilityManager {
    static let shared = ReachabilityManager()
    private let reachability = try! Reachability()
    weak var delegate: ReachabilityManagerDelegate?
    
    var isNetworkAvaiable: Bool {
        return reachability.connection != .unavailable
    }
    
   private init() {}
    
    private func setupReachability() {
        reachability.whenReachable = { [weak self] _ in
        // is network avaiable
            self?.delegate?.isNetworkReachability(isAvaiable: true)
        }
        
        reachability.whenUnreachable = { [weak self] _ in
        // is network not avaiable
            self?.delegate?.isNetworkReachability(isAvaiable: false)
        }
        
    }
    
    func startMonitoring() {
        setupReachability()
        do {
            try reachability.startNotifier()
        } catch  {
            print("is not start reachability")
        }
    }
    
    func stopMonitoring() {
        reachability.stopNotifier()
    }
    
}

