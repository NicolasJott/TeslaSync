//
//  HomeScreen.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/10/23.
//
import SwiftUI
import TeslaSwift

struct HomeScreen: View {
    
    @EnvironmentObject var vm: UserStateViewModel

    
    var body: some View {
        
        if(vm.isBusy){
            ProgressView()
        } else {
            NavigationStack {
            VStack {
                List {
                    ForEach(vm.vehicles, id: \.self.id) { vehicle in
                        VehicleRow(vehicle: vehicle) {
                            print(vehicle.id ?? "id not found")
                        }
                    }
                }
                .onAppear {
                    vm.fetchVehicles()
                }
            }
            .navigationTitle("My Cars")
            .toolbar {
                NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                    }
            }
            }        }
    }
}

struct VehicleRow: View {
    var vehicle: Vehicle
    var tapAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(vehicle.displayName ?? "unknown vehicle")
                    .font(.headline)
                Spacer()
                Text(vehicle.vin ?? "No Color Found")
                    .font(.caption)
                   
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .onTapGesture {
            self.tapAction()
        }
        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
    }
}
