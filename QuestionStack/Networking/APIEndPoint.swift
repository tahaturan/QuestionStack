//
//  APIEndPoint.swift
//  QuestionStack
//
//  Created by Taha Turan on 17.01.2024.
//

import Foundation

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
            return "/questions?site=stackoverflow&page=\(page)"
        case .getQestionAnswers(let questionId):
            return "/questions/\(questionId)/answers?site=stackoverflow"
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
        guard var component = URLComponents(string: baseURL) else { fatalError("Base URL Error")}
        component.path = path
        guard let url = component.url else { fatalError("URL Error From Component") }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
