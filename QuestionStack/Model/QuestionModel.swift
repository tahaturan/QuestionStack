//
//  QuestionModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 18.01.2024.
//

import Foundation

// MARK: - Questions
struct QuestionsModel: Codable {
    let items: [QuestionItem]
}

// MARK: - Item
struct QuestionItem: Codable {
    let tags: [String]
    let owner: Owner
    let isAnswered: Bool
    let viewCount, answerCount, score, lastActivityDate: Int
    let creationDate, questionID: Int
    let link: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case lastActivityDate = "last_activity_date"
        case creationDate = "creation_date"
        case questionID = "question_id"
        case link, title
    }
}

// MARK: - Owner
struct Owner: Codable {
    let accountID: Int?
    let userID: Int?
    let profileImage: String?
    let displayName: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case userID = "user_id"
        case profileImage = "profile_image"
        case displayName = "display_name"
    }
}

