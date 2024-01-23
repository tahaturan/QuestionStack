//
//  RealmQuestionItemModel.swift
//  QuestionStack
//
//  Created by Taha Turan on 23.01.2024.
//

import Foundation
import RealmSwift

class RealmQuestionItem: Object {
    @Persisted(primaryKey: true) var questionID: Int
    @Persisted var tags = List<String>()
    @Persisted var isAnswered: Bool
    @Persisted var viewCount: Int
    @Persisted var answerCount: Int
    @Persisted var score: Int
    @Persisted var creationDate: Int
    @Persisted var title: String
    @Persisted var owner: RealmOwner?
}

class RealmOwner: EmbeddedObject {
    @Persisted var accountID: Int?
    @Persisted var userID: Int?
    @Persisted var profileImage: Data?
    @Persisted var displayName: String
}
