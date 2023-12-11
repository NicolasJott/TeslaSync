//
//  teslasyncApp.swift
//  teslasync
//
//  Created by Nicolas Ott on 11/28/23.
//

import SwiftUI
import TeslaSwift

@main
struct teslasyncApp: App {
    @StateObject var userStateViewModel = UserStateViewModel()

        var body: some Scene {
            WindowGroup {
                NavigationView{
                    ContentView()
                }
                .navigationViewStyle(.stack)
                .environmentObject(userStateViewModel)
            }
        }
}
