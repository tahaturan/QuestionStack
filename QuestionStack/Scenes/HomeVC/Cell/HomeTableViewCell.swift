//
//  HomeTableViewCell.swift
//  QuestionStack
//
//  Created by Taha Turan on 19.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class HomeTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "homeViewCell"
    
    //MARK: - UIComponents
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    private var profileImageView: UIImageView = {
      let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .dummy
        return imageView
    }()
    private lazy var titleLabel: UILabel = createLabel(type: .title)
    private lazy var userNameLabel: UILabel = createLabel(type: .userName)
    private lazy var tagLabel: UILabel = createLabel(type: .tag)
    //MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(tagLabel)
        
        containerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left)
            make.width.height.equalTo(self.screenWidth * 0.4)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalTo(containerView).offset(-10)
        }
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(titleLabel)
            
        }
    }
    
     func configureCell(question: QuestionItem) {
        var tagText: String = ""
        let tags = question.tags
        for tag in tags {
            tagText += "#\(tag), "
        }
        titleLabel.text = question.title
        tagLabel.text = tagText
        userNameLabel.text = question.owner.displayName
         if let userProfileImage = question.owner.profileImage {
             profileImageView.sd_setImage(with: URL(string: userProfileImage))
         }
    }
    func configureCellForRealm(question: RealmQuestionItem) {
        var tagText: String = ""
        let tags = question.tags
        for tag in tags {
            tagText += "#\(tag), "
        }
        titleLabel.text = question.title
        tagLabel.text = tagText
        userNameLabel.text = question.owner?.displayName
        if let profileImageData = question.owner?.profileImage, let profileImage = UIImage(data: profileImageData) {
            profileImageView.image = profileImage
        }
    }
}

//MARK: - FactoryMethod
extension HomeTableViewCell {
   private enum labelType {
        case title
        case tag
        case userName
    }
    private func createLabel(type: labelType) -> UILabel {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        switch type {
        case .title:
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        case .tag:
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = .gray
        case .userName:
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        }
        return label
    }
}
