//
//  RidesTabViewModel.swift
//  Rahul Gupta Edvora Test
//
//  Created by Rahul Gupta on 17/04/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI

// View Model class for Rides list and userDetail
class RidesTabViewModel: ObservableObject {
    // Publishing the Rides to view
    @Published private(set) var selectedRidesData = [RidesModelElement]()
    
    //Storing All the Rides data in different variables
    private(set) var nearestRides  = [RidesModelElement]()
    private(set) var upcomingRides = [RidesModelElement]()
    private(set) var pastRides     = [RidesModelElement]()
    
    // Publishing the User Detail to view
    @Published private(set) var userDetail    : UserModel?

    // Publishing the User Selected State and city
    @Published var selectedState              : String = "State" {
        didSet {
            filteredRide()
        }
    }
    @Published var selectedCity               : String = "City"{
        didSet {
            filteredRide()
        }
    }
    
    //Storing All the states and their city in this
    private(set) var stateCityList = [StateModel]()
    
    // Showing detail view popup
    @Published var displayDetail : Bool = false
    var selectedCellDetail   : RidesModelElement?
    
    // this published variable showing Toast on view
    @Published var showAlert =  Bool()
    // Poperty closure for handling loading status on view
    @Published var showLoading =  Bool()
    // Poperty closure for handling Api call finshed notification on view
    @Published private(set) var didFinishFetch: (() -> ())?

    
    
    @Published var selectedRidesType : RidesType = .nearest {
        didSet {
            switch selectedRidesType {
            case .nearest:
                selectedRidesData = nearestRides
            case .upComming:
                selectedRidesData = upcomingRides
            case .past:
                selectedRidesData = pastRides
            }
            selectedState = "State"
            selectedCity  = "City"
        }
    }
    
    init() {
        fetchUserDatail()
    }
    //API related Variable
    var error: String? {
        didSet {
            DispatchQueue.main.async {
                self.showAlert = true
            }
        }
    }
    private var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.showLoading = self.isLoading
            }
        }
    }
}
// MARK: -  Set and Filter Rides
extension RidesTabViewModel {
    // Seperating Data comming in the Rides api
    private func sepratedRidesData(_ data:RidesModel) {
        for var ride in data {
            // Find the distance of the ride from the user station
            ride.findDistance(userStation: userDetail?.stationCode ?? 0)
            // Storing all the State and city in the State -> City model for the Filter List when needed
            if let state = stateCityList.first(where: { state in
                state.name == ride.state
            }), let indexOf = stateCityList.firstIndex(of: state) {
                if !state.cityList.contains(ride.city) {
                    stateCityList[indexOf].cityList.append(ride.city)
                }
            }
            else {
                let newState = StateModel(name: ride.state, cityList: [ride.city])
                stateCityList.append(newState)
            }
            // Completed storing the current state and city to StateCityList
            
            // Distributing data according to the date
            if let rideDate = ride.rideSystemDate {
                if Calendar.current.isDateInToday(rideDate) {
                    //nearestRides.append(ride)
                }
                else if rideDate < Date() {
                    pastRides.append(ride)
                }
                else {
                    upcomingRides.append(ride)
                }
            }
            nearestRides.append(ride)
        }
        // Sorting data according to distance
        nearestRides = nearestRides.sorted { first, second in
            first.distance < second.distance
        }
        selectedRidesData = nearestRides
    }
    func cityListForSelectedState()->[String] {
        if selectedState == "State" {
            return []
        }
        else {
            let state = stateCityList.filter { st in
                st.name == selectedState
            }
            return state.first?.cityList ?? []
        }
    }
    private func filteredRide() {
        var resultData = [RidesModelElement]()
        switch selectedRidesType {
        case .nearest:
            resultData = nearestRides
        case .upComming:
            resultData = upcomingRides
        case .past:
            resultData = pastRides
        }
        
        // Filtering data according to the selected State
        if selectedState != "State" {
            resultData = resultData.filter({ data in
                data.state == selectedState
            })
        }
        
        // Filtering data according to the selected city
        if selectedCity != "City" {
            resultData = resultData.filter({ data in
                data.city == selectedCity
            })
        }
        // Publishing data on the View
        selectedRidesData = resultData
    }
}
// MARK: -  Network Calls
extension RidesTabViewModel {
    private func fetchUserDatail() {
        // Calling the api for User Details
        isLoading = true
        let model = NetworkManager.sharedInstance
        model.userDetail({ [weak self](result) in
            guard let self = self else {return}
            self.isLoading = false
            switch result{
            case .success(let res):
                DispatchQueue.main.async {
                    self.userDetail = res
                    self.didFinishFetch?()
                }
                self.fetchRides()
                print(res)
            case .failure(let err):
                switch err {
                case .errorReport(let desc):
                    self.error = desc
                    print(desc)
                }
            }
        })
    }
    private func fetchRides() {
        // Calling the api for list of  /rides
        isLoading = true
        let model = NetworkManager.sharedInstance
        model.ridesList({ [weak self](result) in
            guard let self = self else {return}
            self.isLoading = false
            switch result{
            case .success(let res):
                self.sepratedRidesData(res)
            case .failure(let err):
                switch err {
                case .errorReport(let desc):
                    self.error = desc
                    print(desc)
                }
            }
        })
    }
}
