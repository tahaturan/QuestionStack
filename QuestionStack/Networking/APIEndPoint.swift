//
//  APIEndPoint.swift
//  QuestionStack
//
//  Created by Taha Turan on 17.01.2024.
//

import Foundation

enum NetworkError: String, Error {
    case unableToComplateError
    case invalidResponse
    case invalidData
    case unknownError
    case decodingError
}

enum HTTPMethod: String {
    case get = "GET"
}

protocol APIEndPointDelegate {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    func request() -> URLRequest
}

enum APIEndPoint {
    case getQuestions(page: Int)
    case getQestionAnswers(questionId: Int)
}

extension APIEndPoint: APIEndPointDelegate {
    var baseURL: String {
        return "https://api.stackexchange.com/2.3"
    }
    
    var path: String {
        switch self {
        case .getQuestions(let page):
            return "\(baseURL)/questions?site=stackoverflow&page=\(page)"
        case .getQestionAnswers(let questionId):
            return "\(baseURL)/questions/\(questionId)/answers?site=stackoverflow"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getQuestions(_):
            return .get
        case .getQestionAnswers(_):
            return .get
        }
    }
    
    func request() -> URLRequest {
        
        let url = URL(string: path)!
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}
