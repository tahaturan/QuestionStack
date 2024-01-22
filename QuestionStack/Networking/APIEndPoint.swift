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
    func questionApiURL() -> String
    func request() -> URLRequest
}

enum APIEndPoint {
    case getQuestions(page: Int)
    case getQestionAnswers(questionId: Int)
    case searchQuestions(searchText: String)
}

extension APIEndPoint: APIEndPointDelegate {
    var baseURL: String {
        return "https://api.stackexchange.com/2.3"
        
    }
    
    var path: String {
        switch self {
        case .getQuestions(let page):
            return "/questions?site=stackoverflow&page=\(page)&pagesize=10&order=desc&sort=activity"
        case .getQestionAnswers(let questionId):
            return "/questions/\(questionId)/answers?site=stackoverflow"
        case .searchQuestions(searchText: let searchText):
            return "/search?order=desc&sort=activity&intitle=\(searchText)&site=stackoverflow"
        }
    
    }
    
    var method: HTTPMethod {
        switch self {
        case .getQuestions(_):
            return .get
        case .getQestionAnswers(_):
            return .get
        case .searchQuestions(_):
            return .get
        }
    }
    func questionApiURL() -> String {
        return "\(baseURL)\(path)"
    }
    
    func request() -> URLRequest {
        
        guard let apiURL = URLComponents(string: questionApiURL()) else {
            fatalError("URL Compinents is not")
        }
        guard let url = apiURL.url else { fatalError("URL is Not Created") }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
