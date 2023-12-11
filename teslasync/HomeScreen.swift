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
                        Button(action: {
                            Task {
                                print(vehicle.id ?? "unknown id")
                            }
                        }) {
                            HStack{
                                VStack(alignment: .leading){
                                    Text(vehicle.displayName ?? "unknown vehicle")
                                        .font(.headline)
                                        .foregroundStyle(Color(.black))
                                     
                                    
                                    Text(vehicle.vin ?? "No Color Found")
                                        .font(.subheadline)
                                        .foregroundStyle(Color(.gray))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
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

