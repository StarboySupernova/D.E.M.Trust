//
//  D_E_M_TrustApp.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/15/22.
//

import SwiftUI

@main
struct D_E_M_TrustApp: App {
        
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            /*LaunchPoint()
                .modifier(DarkModeViewModifier())
                .environmentObject(modelData)*/
            OperationsView()
        }
    }
}
