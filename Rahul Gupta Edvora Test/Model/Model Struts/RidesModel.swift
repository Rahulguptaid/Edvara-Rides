//
//  RidesModel.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import Foundation
import SwiftUI
// MARK: - RidesModelElement
struct RidesModelElement: Codable,Identifiable,Equatable {
    let id, originStationCode: Int
    let stationPath: [Int]
    let destinationStationCode: Int
    let date: String
    let mapURL: String
    let state, city: String
    
    var distance = 0
    
    var rideSystemDate : Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm a"
        return dateFormatter.date(from: date)
    }
    
    var rideFormattedDate : String {
        guard let rideSysDate = rideSystemDate else {
            return "Nil"
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        return dateFormatter.string(from: rideSysDate)
    }

    var stationPathString : String {
        var strPath = ""
        for path in stationPath {
            strPath += "\(path), "
        }
        strPath.removeLast(2)
        return strPath
    }
    
    mutating  func findDistance(userStation:Int) {
        var dis = abs(userStation-(stationPath.first ?? 0))
        for st in stationPath {
            if abs(userStation-st) < dis  {
                dis = abs(userStation-st)
            }
        }
        self.distance = dis
    }
    enum CodingKeys: String, CodingKey {
        case id
        case originStationCode = "origin_station_code"
        case stationPath = "station_path"
        case destinationStationCode = "destination_station_code"
        case date
        case mapURL = "map_url"
        case state, city
    }
}

typealias RidesModel = [RidesModelElement]
