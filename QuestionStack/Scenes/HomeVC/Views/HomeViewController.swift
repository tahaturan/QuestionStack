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
    private lazy var homeViewModel: HomeViewModel = HomeViewModel(service: NetworkManager())
    private var questionList: [QuestionItem] = []
    
    //MARK: - UICompanents
    let searchBarView: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    private var tableView: UITableView = UITableView()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeViewModel.delegate = self
        homeViewModel.load()
    }
}
//MARK: - Helper
extension HomeViewController {
    private func setupUI(){
        view.backgroundColor = .white
        title = "QuestionStack"
        makeSearcBarView()
        makeTableView()
    }
}
//MARK: - makeComponents
extension HomeViewController{
    private func makeTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBarView.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    private func makeSearcBarView() {
        view.addSubview(searchBarView)
        searchBarView.returnKeyType = .search
        searchBarView.searchBarStyle = .minimal
        searchBarView.showsCancelButton = true
        searchBarView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
}
//MARK: - UItableViewDelagateDataSource
extension HomeViewController: TableViewDelegateDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        let question = questionList[indexPath.row]
        cell.configureCell(question: question)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

//MARK: - HomeViewControllerDelagate
extension HomeViewController: HomeViewModelDelegate {
    
    func handleOutput(_ output: HomeViewModelOutput) {
        DispatchQueue.main.async {
            switch output {
            case .questions(let array):
                self.questionList = array
            case .error(let networkError):
                print(networkError.rawValue)
            }
            self.tableView.reloadData()
        }
    }
}
