//
//  ContentView.swift
//  teslasync
//
//  Created by Nicolas Ott on 11/28/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vm: UserStateViewModel
        
        var body: some View {
            if (vm.isAuthenticated) {
                HomeScreen()
            } else {
                TeslaWebLogin()
            }
        }
}

