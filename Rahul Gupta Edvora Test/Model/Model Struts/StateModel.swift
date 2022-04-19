//
//  StateModel.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import Foundation

struct StateModel : CustomStringConvertible,Equatable,Identifiable,Hashable {
    var id :UUID {
        return UUID()
    }
    var name       = String()
    var cityList   = [String]()
    var description : String {
        return name
    }
}
