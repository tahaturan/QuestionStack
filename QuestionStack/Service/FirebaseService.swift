//
//  FirebaseService.swift
//  QuestionStack
//
//  Created by Taha Turan on 1.02.2024.
//

import Foundation
import Firebase
import FirebaseAuth

final class FirebaseService {
    static let shared = FirebaseService()
    
    private init() {}
    
    func signUp(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let user = authResult?.user {
                completion(.success(user))
            }
        }
    }
    
    func signIn(email: String, password: String, comletion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                comletion(.failure(error))
                return
            }
            if let user = authResult?.user {
                comletion(.success(user))
            }
        }
    }
    func signOut(comletion:@escaping(Result<Bool, Error>) ->Void) {
        do {
            try Auth.auth().signOut()
            comletion(.success(true))
        } catch  {
            comletion(.failure(error))
        }
    }
    func currentUser() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
}
