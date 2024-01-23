//
//  QuestionAnswerModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 18.01.2024.
//

import Foundation

// MARK: - QuestionsAnswer
struct QuestionsAnswerModel: Codable {
    let items: [AnswerItem]
}

// MARK: - Item
struct AnswerItem: Codable {
    let owner: Owner
    let isAccepted: Bool
    let score, lastActivityDate: Int
    let lastEditDate: Int?
    let creationDate, answerID, questionID: Int
    let contentLicense: String

    enum CodingKeys: String, CodingKey {
        case owner
        case isAccepted = "is_accepted"
        case score
        case lastActivityDate = "last_activity_date"
        case lastEditDate = "last_edit_date"
        case creationDate = "creation_date"
        case answerID = "answer_id"
        case questionID = "question_id"
        case contentLicense = "content_license"
    }
}

// MARK: - Owner
struct AnswerOwner: Codable {
    let accountID, reputation, userID: Int
    let userType: String
    let profileImage: String
    let displayName: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case accountID = "account_id"
        case reputation
        case userID = "user_id"
        case userType = "user_type"
        case profileImage = "profile_image"
        case displayName = "display_name"
        case link
    }
}
