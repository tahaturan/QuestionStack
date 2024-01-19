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
    private var homeViewModel: HomeViewModel = HomeViewModel()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeViewModel.loadData()
        setupLayout()
        
        
    }
}
//MARK: - Helper
extension HomeViewController {
    private func setupUI(){
        view.backgroundColor = .red
    }
    private func setupLayout(){
        homeViewModel.questionList.bind { list in
            //TODO: bind
        }
    }
}
