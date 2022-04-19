//
//  NetworkManager.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import UIKit

enum NetworkResponse :String {
    case success
    case authenticationError = "You need to authenticate first."
    case badRequest          = "Bad Request"
    case outdated            = "The url you requested is outdated."
    case failed              = "Network request failed."
    case noData              = "Response returned with no data to decode."
    case unableToDecode      = "we couldn't decode the response"
}
enum APIResult<String>{
    case success
    case failure(String)
}
enum APIError :Error{
    case errorReport(desc:String)
}
struct NetworkManager {
    static let sharedInstance = NetworkManager()
    private init() {}
    static let environment :NetworkEnvironment = .development
    static let contentType = "application/x-www-form-urlencoded"
    let router = Router<APIEndPoint>()
    
    fileprivate func handleNetworkResponse(_ response : HTTPURLResponse, forData data : Data = Data())->
        APIResult<String>{
            switch response.statusCode{
            case 200...299 : return.success
            case 401...500 : return.failure(NetworkResponse.authenticationError.rawValue)
            case 501...599 : return.failure(NetworkResponse.badRequest.rawValue)
            case 600       : return.failure(NetworkResponse.outdated.rawValue)
            default        : return.failure(NetworkResponse.failed.rawValue)
            }
    }
    func handleAPICalling<T:Codable>(request:APIEndPoint,completion: @escaping ((Result<T,APIError>) -> Void)){
        router.request(request) { (data, response, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(.failure(.errorReport(desc: "Please check your network connection.")))
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response,forData:data ?? Data())
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(.failure(.errorReport(desc: NetworkResponse.noData.rawValue)))
                            return
                        }
                        do {
                            let result = try JSONDecoder().decode(T.self, from: responseData)
                            completion(.success(result))
                        }
                        catch {
                            print(error.localizedDescription)
                            completion(.failure(.errorReport(desc: "Data Not Found")))
                        }
                    case .failure(let networkFailureError):
                        completion(.failure(.errorReport(desc: networkFailureError)))
                    }
                }
            }
        }
    }
}
