//
//  HomeScreen.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/10/23.
//
import SwiftUI
import TeslaSwift

struct HomeScreen: View {
    
    @Binding var showVehiclePicker: Bool
    @EnvironmentObject var vm: UserStateViewModel
    
    func getChargeState(vehicle: Vehicle) async {
         do {
             let vehicleData = try await vm.api.getAllData(vehicle)
             guard let jsonString = vehicleData.jsonString else { return }
             print(jsonString)
         } catch let error {
             print("Error:", error)
         }
     }
    
    func setCurrentVehicle(vehicle: Vehicle) {
        print("Setting Current Vehicle")
        vm.currentVehicle = vehicle
        showVehiclePicker.toggle()
        
    }
    
    
    var body: some View {
        
        if(vm.isBusy){
            ProgressView()
        } else {
            NavigationStack{
                VStack {
                    List {
                        ForEach(vm.vehicles, id: \.self.id) { vehicle in
                            VehicleRow(vehicle: vehicle) {
                                Task {
                                        setCurrentVehicle(vehicle: vehicle)
                                    }
                            }
                        }
                    }
                }
                .navigationTitle("Select A Vehicle")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss", action: {
                            showVehiclePicker.toggle()
                                })
                    }
                    
                }
            }
               
        }
    }
}


