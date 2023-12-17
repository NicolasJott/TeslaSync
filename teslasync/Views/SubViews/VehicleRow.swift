//
//  VehicleRow.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/11/23.
//

import SwiftUI
import TeslaSwift

struct VehicleRow: View {
    var vehicle: Vehicle
    @EnvironmentObject var vm: UserStateViewModel
    var tapAction: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text(vehicle.displayName ?? "unknown vehicle")
                    .font(.headline)
                Spacer()
                Text(vehicle.vin ?? "No Color Found")
                    .font(.subheadline)
                    .foregroundStyle(Color(.systemGray))
                   
            }
            Spacer()
            if let currentVehicleId = vm.currentVehicle?.id, let vehicleId = vehicle.id {
                Image(systemName: currentVehicleId == vehicleId ? "checkmark.circle" : "circle")
            }
            
        }
        .onTapGesture {
            self.tapAction()
        }
        
        .padding(EdgeInsets(top: 6, leading: 6, bottom: 6, trailing: 6))
    }
    
}

