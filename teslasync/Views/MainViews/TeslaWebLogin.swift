//
//  TeslaWebLogin.swift
//  teslasync
//
//  Created by Nicolas Ott on 12/10/23.
//

import TeslaSwift
import SwiftUI

struct TeslaWebLogin: UIViewControllerRepresentable {
    @EnvironmentObject var vm: UserStateViewModel
    
    
    
    func makeUIViewController(context: Context) -> TeslaWebLoginViewController {
        let (webloginViewController, result) = vm.api.authenticateWeb()
        Task { @MainActor in
                do {
                     _ = try await result()
                    print("Authentication success")
                    guard vm.api.isAuthenticated else { return }
                    UserDefaults.standard.set(vm.api.token?.jsonString, forKey: "tesla.token")
                    vm.isAuthenticated = vm.api.isAuthenticated
                } catch let error {
                    print("Error", error)
               }
        }
        return webloginViewController!
    }
    
    func updateUIViewController(_ uiViewController: TeslaWebLoginViewController, context: Context) {
    }
    
}
