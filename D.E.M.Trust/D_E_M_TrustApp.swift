//
//  D_E_M_TrustApp.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/15/22.
//

import SwiftUI
import Firebase

@main
struct D_E_M_TrustApp: App {
    /* MARK:
     Marked code shows how to use UIKit's AppDelegate in SwiftUI. Works just fine for our purposes but simply configuring Firebase in a simple init is much more readable
     @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
     */
    @StateObject private var modelData = ModelData()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HeroPageView()
             .modifier(DarkModeViewModifier())
             .environmentObject(modelData) 
        }
    }
}

/*
 Marked code shows how to use UIKit's AppDelegate in SwiftUI. Works just fine for our purposes but simply configuring Firebase in a simple init is much more readable
 class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
 }
 */

