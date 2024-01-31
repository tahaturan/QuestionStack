//
//  FireBaseError.swift
//  QuestionStack
//
//  Created by Taha Turan on 31.01.2024.
//

import Foundation

enum FireBaseError: Error {
    case userNotFound
    case wrongPassword
    case networkError
    case unknownError
    case customError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .userNotFound:
            return "User is Not Found"
        case .wrongPassword:
            return "Wrong Password"
        case .networkError:
            return "Netork is not avaiable"
        case .unknownError:
            return "Unknown Error"
        case .customError(let message):
            return message
        }
    }
}
