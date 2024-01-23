//
//  RealmService.swift
//  QuestionStack
//
//  Created by Taha Turan on 22.01.2024.
//

import Foundation
import RealmSwift

final class RealmService {
    private var realm: Realm
    
    init() {
        self.realm = try! Realm()
    }
    
    func saveQuestion(questionList: [RealmQuestionItem]) {
        try! realm.write({
            realm.delete(realm.objects(RealmQuestionItem.self))
            
            realm.add(questionList, update: .modified)
        })
    }
    
    func loadQuestions() -> [RealmQuestionItem] {
        return Array(realm.objects(RealmQuestionItem.self))
    }
}
