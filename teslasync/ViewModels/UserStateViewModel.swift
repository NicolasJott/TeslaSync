//
//  UserStateViewModel.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/10/23.
//

import Foundation
import TeslaSwift

enum UserStateError: Error{
    case signInError, signOutError
}

let clientID = ProcessInfo.processInfo.environment["CLIENT_ID"] ?? ""
let clientSecret = ProcessInfo.processInfo.environment["CLIENT_SECRET"] ?? ""
let redirectURI = ProcessInfo.processInfo.environment["REDIRECT_URI"] ?? ""
let teslaAPI = TeslaAPI.fleetAPI(region: .northAmericaAsiaPacific, clientID: clientID, clientSecret: clientSecret, redirectURI: redirectURI)

@MainActor
class UserStateViewModel: ObservableObject {
    
    @Published var vehicles: [Vehicle] = []
    @Published var currentVehicle: Vehicle? 
    @Published var isAuthenticated = false
    @Published var isBusy = false
    let api: TeslaSwift
    init() {
            api = TeslaSwift(teslaAPI: teslaAPI)
        api.debuggingEnabled = true
        }
    
    func fetchVehicles() {
        Task {
            do {
                let fetchedVehicles = try await api.getVehicles()
                print(fetchedVehicles.jsonString)
                vehicles = fetchedVehicles
                currentVehicle = fetchedVehicles[0]
                
            
                
            } catch let error {
                print("Failed to fetch vehicles:", error)
            }
        }
    }
  
   
    
    func signOut() async -> Result<Bool, UserStateError>  {
        isBusy = true
        do{
            api.logout()
            isAuthenticated = false
            isBusy = false
            UserDefaults.standard.removeObject(forKey: "tesla.token")
            return .success(true)
        }
    }
}
