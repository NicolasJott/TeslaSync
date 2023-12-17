//
//  ContentView.swift
//  teslasync
//
//  Created by Nicolas Ott on 11/28/23.
//

import SwiftUI
import TeslaSwift

struct ContentView: View {
    @EnvironmentObject var vm: UserStateViewModel

    
        var body: some View {
            
            if isAuthenticated() {
                VehicleTabView()
            } else {
                TeslaWebLogin()
            }
        }
    
    private func isAuthenticated() -> Bool {
        if let jsonString = UserDefaults.standard.object(forKey: "tesla.token") as? String,
           let data = jsonString.data(using: .utf8),
           let token = try? JSONDecoder().decode(AuthToken.self, from: data) {
            vm.api.reuse(token: token)
            return true
        } else {
            return false
        }

        
    }
}

