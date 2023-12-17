//
//  ControlsView.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/16/23.
//

import SwiftUI
import TeslaSwift

struct ControlsView: View {
    @EnvironmentObject var vm: UserStateViewModel
    
    func unlockVehicle() async {
        do {
            print("Unlocking Vehicle")
            let response = try await vm.api.sendCommandToVehicle(vm.currentVehicle!, command: VehicleCommand.unlockDoors)
            if let reason = response.reason {
                print("Vehicle Unlock Response: ", reason)
            }
        } catch let error {
            print("Error Unlocking Vehicle: ", error)
        }
        }
    
    func lockVehicle() async {
        do {
            print("Locking Vehicle")
            let response = try await vm.api.sendCommandToVehicle(vm.currentVehicle!, command: VehicleCommand.lockDoors)
            if let reason = response.reason {
                print("Vehicle Lock Response: ", reason)
            }
        } catch let error {
            print("Error Locking Vehicle: ", error)
        }
    }
    
    func flashLights() async {
        do {
            print("Flashing Lights")
            let response = try await vm.api.sendCommandToVehicle(vm.currentVehicle!, command: VehicleCommand.flashLights)
            if let reason = response.reason {
                print("Flash Lights Response: ", reason)
            }
        } catch let error {
            print("Error Flashing Lights: ", error)
        }
    }
    
    func honkHorn() async {
        do {
            print("Flashing Lights")
            let response = try await vm.api.sendCommandToVehicle(vm.currentVehicle!, command: VehicleCommand.honkHorn)
            if let reason = response.reason {
                print("Honk Horn Response: ", reason)
            }
        } catch let error {
            print("Error Honking Horn: ", error)
        }
    }
        

    var body: some View {
        
        if (vm.currentVehicle != nil) {
            NavigationStack {
                Text("Vehicle Controls")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    // Use LazyVGrid for a grid layout
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        // First button
                        Button(action: {
                            Task { await unlockVehicle() }
                        }) {
                            VStack {
                                Image(systemName: "lock.open.fill") // Use a relevant system icon
                                    .font(.largeTitle)
                                Text("Unlock Vehicle")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red) // Use Tesla's red color
                            .cornerRadius(25)
                        }
                        
                        // Second button
                        Button(action: {
                            Task { await lockVehicle() }
                        }) {
                            VStack {
                                Image(systemName: "lock.fill") // Use a relevant system icon
                                    .font(.largeTitle)
                                Text("Lock Vehicle")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red) // Use Tesla's red color
                            .cornerRadius(25)
                        }
                        
                        // Third button
                        Button(action: {
                            Task { await honkHorn() }
                        }) {
                            VStack {
                                Image(systemName: "horn.blast.fill") // Use a relevant system icon
                                    .font(.largeTitle)
                                Text("Honk Horn")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red) // Use Tesla's red color
                            .cornerRadius(25)
                        }
                        
                        // Fourth button
                        Button(action: {
                            Task { await flashLights() }
                        }) {
                            VStack {
                                Image(systemName: "headlight.high.beam") // Use a relevant system icon
                                    .font(.largeTitle)
                                Text("Flash Lights")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red) // Use Tesla's red color
                            .cornerRadius(25)
                        }
                    }
                    .padding() // Add padding around the grid
                    Text("Window Controls")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        // Use LazyVGrid for a grid layout
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            // First button
                            Button(action: {
                                Task { await unlockVehicle() }
                            }) {
                                VStack {
                                    Image(systemName: "arrowtriangle.up.arrowtriangle.down.window.right") // Use a relevant system icon
                                        .font(.largeTitle)
                                    Text("Vent Windows")
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red) // Use Tesla's red color
                                .cornerRadius(25)
                            }
                            
                            // Second button
                            Button(action: {
                                Task { await lockVehicle() }
                            }) {
                                VStack {
                                    Image(systemName: "arrowtriangle.up.arrowtriangle.down.window.right") // Use a relevant system icon
                                        .font(.largeTitle)
                                    Text("Close Windows")
                                        .font(.headline)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red) // Use Tesla's red color
                                .cornerRadius(25)
                            }
                        }
                        .padding() // Add padding around the grid
                        Spacer()
            }
        } else {
            ProgressView()
        }
        }
}

#Preview {
    ControlsView()
}
