//
//  TabView.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/16/23.
//

import SwiftUI

struct VehicleTabView: View {
    @State var showVehiclePicker: Bool = false
    @EnvironmentObject var vm: UserStateViewModel
    
    var body: some View {
        NavigationStack{
            TabView {
                ControlsView()
                    .tabItem {
                        Label("Controls", systemImage: "slider.vertical.3")
                    }
                
                ScheduleView()
                    .tabItem {
                        Label("Schedule", systemImage: "calendar")
                    }
            }
        }.sheet(isPresented: $showVehiclePicker, content: {
            HomeScreen(showVehiclePicker: $showVehiclePicker)
        })
        .navigationTitle(vm.currentVehicle?.displayName ?? "")
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button("Car", systemImage: "car.fill", action: {
                    showVehiclePicker.toggle()
                        })
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            }
        }.onAppear {
            vm.fetchVehicles()
        }
        
    }

}

#Preview {
    VehicleTabView()
}
