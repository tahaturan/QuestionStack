//
//  HomeViewController.swift
//  QuestionStack
//
//  Created by Taha Turan on 17.01.2024.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    //MARK: - Properties

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
}
//MARK: - Helper
extension HomeViewController {
    private func setupUI(){
        view.backgroundColor = .red
    }
    private func setupLayout(){
       
    }
}
