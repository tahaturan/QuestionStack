//
//  DetailViewController.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - Properties

    var detailViewModel: DetailViewModel?
    var questionItem: QuestionItem?
    private var answerList: [AnswerItem] = []

    // MARK: - UIComponents

    private lazy var titleLabel: UILabel = createLabel(type: .title)
    private let profileImageView: UIImageView = UIImageView()
    private lazy var nameLabel: UILabel = createLabel(type: .name)
    private lazy var dateLabel: UILabel = createLabel(type: .date)
    private lazy var answerCountLabel: UILabel = createLabel(type: .anwserCount)
    private var tableView: UITableView = UITableView()
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .black
        return indicator
    }()
    private lazy var answerTitleLabel: UILabel = createLabel(type: .title)
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detailViewModel?.delagate = self
        detailViewModel?.getAnswers()
    }
}

// MARK: - Helper

extension DetailViewController {
    private func setupUI() {
        view.backgroundColor = .white
        title = "Answers"
        setupTitleLabel()
        setupProfileImageView()
        setupNameLabel()
        setupDateLabel()
        setupAnswerCountLabel()
        setupAnswerTitleLabel()
        setupTableView()
        setupActivityIndicator()
    }
}

// MARK: - SetupCompanents

extension DetailViewController {
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = questionItem?.title
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview().inset(10)
        }
    }

    private func setupProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
        view.addSubview(profileImageView)
        profileImageView.sd_setImage(with: URL(string: (questionItem?.owner.profileImage)!))
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(screenHeight * 0.1)
        }
    }

    private func setupNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.text = questionItem?.owner.displayName
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
    }

    private func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.text = questionItem?.creationDate.toDayMonthYearString()
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(profileImageView.snp.right).offset(10)
        }
    }
    private func setupAnswerCountLabel() {
        view.addSubview(answerCountLabel)
        answerCountLabel.text = "Answer: \(questionItem!.answerCount)"
        answerCountLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(dateLabel)
        }
    }
    private func setupAnswerTitleLabel() {
        view.addSubview(answerTitleLabel)
        answerTitleLabel.text = "Answers:"
        answerTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.left.equalTo(profileImageView)
        }
    }
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.snp.makeConstraints { make in
            make.top.equalTo(answerTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview()
        }
    }
    private func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - TableViewDelagateDataSource
extension DetailViewController: TableViewDelegateDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return answerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        let answer = answerList[indexPath.row]
        cell.configureCell(answer: answer)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return screenHeight * 0.15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - DetailViewModelDelegate
extension DetailViewController: DetailViewModelDelegate {
    func handleOutput(_ output: DetailViewModelOutput) {
        switch output {
        case .answers(let answers):
            self.answerList = answers
        case .error(let networkError):
            print(networkError)
        case .setLoading(let isLoading):
            DispatchQueue.main.async {
                if isLoading {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}

// MARK: - FactoryMethod

extension DetailViewController {
    enum LabelTypes {
        case title
        case name
        case date
        case anwserCount
    }

    func createLabel(type: LabelTypes) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0

        switch type {
        case .title:
            label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        case .name:
            label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        case .date:
            label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        case .anwserCount:
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        }
        return label
    }
}
