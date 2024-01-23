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
    let viewCount, answerCount, score: Int
    let creationDate, questionID: Int
    let title: String

    enum CodingKeys: String, CodingKey {
        case tags, owner
        case isAnswered = "is_answered"
        case viewCount = "view_count"
        case answerCount = "answer_count"
        case score
        case creationDate = "creation_date"
        case questionID = "question_id"
        case title
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


extension QuestionItem {
    func toRealmQuestionItem(completion: @escaping (RealmQuestionItem?) -> Void) {
        let realmQuestion = RealmQuestionItem()
        realmQuestion.questionID = self.questionID
        realmQuestion.viewCount = self.viewCount
        realmQuestion.answerCount = self.answerCount
        realmQuestion.score = self.score
        realmQuestion.creationDate = self.creationDate
        realmQuestion.title = self.title
        realmQuestion.tags.append(objectsIn: self.tags)
        
        if let profileImageUrl = self.owner.profileImage {
            downloadImageData(urlString: profileImageUrl) { imageData in
                DispatchQueue.main.async {
                    let realmOwner = RealmOwner()
                    realmOwner.profileImage = imageData
                    realmOwner.accountID = self.owner.accountID
                    realmOwner.userID = self.owner.userID
                    realmOwner.displayName = self.owner.displayName
                    
                    realmQuestion.owner = realmOwner
                    completion(realmQuestion)
                }
            }
        } else {
            completion(realmQuestion)
        }
    }
    
    private func downloadImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}
