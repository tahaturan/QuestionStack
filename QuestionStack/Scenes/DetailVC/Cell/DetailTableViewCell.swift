//
//  DetailTableViewCell.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class DetailTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let identifier: String = "detailViewCell"
    
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
    private lazy var dateLabel: UILabel = createLabel(type: .date)
    private lazy var scoreLabel: UILabel = createLabel(type: .score)
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
        containerView.addSubview(dateLabel)
        containerView.addSubview(scoreLabel)
        
        containerView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(10)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left)
            make.width.height.equalTo(self.screenWidth * 0.25)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(10)
            make.right.equalTo(containerView).offset(10)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel)
        }
        scoreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(dateLabel.snp.bottom).offset(20)
            make.left.equalTo(dateLabel)
        }
    }
    
     func configureCell(answer: AnswerItem) {
         titleLabel.text = answer.owner.displayName
         dateLabel.text = answer.creationDate.toDayMonthYearString()
         scoreLabel.text = "score: \(answer.score)"
         if let userProfileImage = answer.owner.profileImage {
             profileImageView.sd_setImage(with: URL(string: userProfileImage))
         }
    }
}

//MARK: - FactoryMethod
extension DetailTableViewCell {
   private enum labelType {
        case title
        case date
        case userName
       case score
    }
    private func createLabel(type: labelType) -> UILabel {
        let label: UILabel = UILabel()
        label.numberOfLines = 2
        switch type {
        case .title:
            label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        case .date:
            label.font = UIFont.systemFont(ofSize: 12, weight: .light)
            label.textColor = .gray
        case .userName:
            label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        case .score:
            label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        }
        return label
    }
}
