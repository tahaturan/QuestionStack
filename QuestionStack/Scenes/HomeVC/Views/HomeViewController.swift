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
    var homeViewModel: HomeViewModel?
    private var questionList: [QuestionItem] = []
    private var filteredList: [QuestionItem] = []
    private var realmQuestionList: [RealmQuestionItem] = []

    //MARK: - UICompanents
    private var tableView: UITableView = UITableView()
    private let searchVC: UISearchController = UISearchController(searchResultsController: nil)
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        homeViewModel?.delegate = self
        homeViewModel?.loadData()
    }
}
//MARK: - Helper
extension HomeViewController {
    private func setupUI(){
        view.backgroundColor = .white
        title = "QuestionStack"
        navigationController?.navigationBar.prefersLargeTitles = true
        makeSearcBarView()
        makeTableView()
        makeActivityIndicator()
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
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    private func makeSearcBarView() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        if Connectivity.shared.isConnected {
            searchVC.searchBar.isEnabled = true
        } else {
            searchVC.searchBar.isEnabled = false
        }
    }
    private func makeActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
//MARK: - UItableViewDelagateDataSource
extension HomeViewController: TableViewDelegateDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Connectivity.shared.isConnected ? filteredList.count : realmQuestionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        if Connectivity.shared.isConnected {
            let question = filteredList[indexPath.row]
            cell.configureCell(question: question)
        } else {
            let question = realmQuestionList[indexPath.row]
            cell.configureCellForRealm(question: question)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.18
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let scrollViewHeight = scrollView.frame.height
        let contentHeight = scrollView.contentSize.height
        
        if Connectivity.shared.isConnected {
            if  searchVC.searchBar.text!.isEmpty {
                if position > (contentHeight - 100 - scrollViewHeight) {
                    homeViewModel?.getQuestions()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if Connectivity.shared.isConnected {
            let questionItem = filteredList[indexPath.row]
            let detailVC = DetailViewControllerBuilder.makeDetailViewController(questionItem: questionItem)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

//MARK: - HomeViewModelDelagate
extension HomeViewController: HomeViewModelDelegate {
    
    func handleOutput(_ output: HomeViewModelOutput) {
                switch output {
                case .questions(let questions):
                    self.questionList.append(contentsOf: questions)
                    self.filteredList = self.questionList
                case .error(let networkError):
                    print(networkError.rawValue)
                case .setLoading(let isLoading):
                    DispatchQueue.main.async {
                        if isLoading {
                            self.activityIndicator.startAnimating()
                        }else {
                            
                            self.activityIndicator.stopAnimating()
                        }
                    }
                case .searchQuestions(let questions):
                    self.filteredList = questions
                case .questionRealm(let questionItemsRealm):
                    self.realmQuestionList = questionItemsRealm
                }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
                
    }
}
//MARK: - UISearchBarDelegate
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.async {
            if searchText.isEmpty {
                self.filteredList = self.questionList
            } else {
                self.filteredList = self.questionList.filter({ question in
                    question.title.lowercased().contains(searchText.lowercased())
                })
            }
            self.tableView.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchBar.resignFirstResponder()
        self.homeViewModel?.getSearchQuestion(query: searchText)

    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        homeViewModel?.getQuestions()
    }
}
