//
//  UserModel.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import Foundation

// MARK: - UserModel
struct UserModel: Codable {
    let stationCode: Int
    let name: String
    let url: String

    var imageURL : URL {
        if let igURL = URL(string: url) {
            return igURL
        }
        else {
            return URL(string: "https://via.placeholder.com/200x200.jpg")!
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case stationCode = "station_code"
        case name, url
    }
}
