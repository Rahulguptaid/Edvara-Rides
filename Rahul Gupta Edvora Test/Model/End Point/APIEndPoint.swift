//
//  APIEndPoint.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//
import UIKit

enum NetworkEnvironment : String {
    case development  = "https://assessment.api.vweb.app"
}
enum APIEndPoint {
    case rides
    case user
}
extension APIEndPoint:EndPointType {
    var environmentBaseURL : String {
        return NetworkManager.environment.rawValue
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch  self {
        case .rides:
            return "/rides"
        case .user:
            return "user"
        }
    }
    var httpMethod: HTTPMethod {
        return .get
    }
    var task: HTTPTask {
        switch self {
        case .rides,.user:
            return .request
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
