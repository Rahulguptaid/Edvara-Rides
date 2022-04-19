//
//  ApiEndPointManager.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import Foundation

extension NetworkManager {
    func ridesList(_ completion: @escaping ((Result<RidesModel,APIError>) -> Void)) {
        handleAPICalling(request: .rides, completion: completion)
    }
    func userDetail(_ completion: @escaping ((Result<UserModel,APIError>) -> Void)) {
        handleAPICalling(request: .user, completion: completion)
    }
}


