//
//  SettingsView.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/10/23.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var vm: UserStateViewModel

    var body: some View {
            List {
                Button(action: {
                    Task {
                        // Call the async signOut function inside a Task
                        await vm.signOut()
                    }
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
        }
}
