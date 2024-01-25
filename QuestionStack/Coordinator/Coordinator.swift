//
//  Coordinator.swift
//  QuestionStack
//
//  Created by Taha Turan on 25.01.2024.
//

import UIKit
protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}
