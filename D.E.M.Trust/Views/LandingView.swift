//
//  LandingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/23/22.
//

import SwiftUI

struct LandingView: View {
    @State private var fullscreen: Bool = false
    @Binding var selectedTab: String
    
    //hiding tab bar
    init(selectedTab: Binding<String>) {
        self._selectedTab = selectedTab
        UITabBar.appearance().isHidden = true //experiment with isTranslucent
    }
    
    var body: some View {
        //Tab view with tabs
        TabView(selection: $selectedTab) {
            //Views
            Home()
                .tag("Home")
            
            OperationsView()
                .tag("Operations")
            
            TrainingView()
                .tag("Training")
            
            /*
             //removing videoplayerview from tab view to avoid the behaviour tab view adopts when it has more than five children
             VideoPlayerView(fullscreen: $fullscreen)
                .tag("Documentaries")
                .onTapGesture {
                    fullscreen = true
                }
             */
            
            ConversationView()
                .tag("Messaging")
            
            /*
             //removing galleryview from tab view to avoid the behaviour tab view adopts when it has more than five children
            GalleryView()
                .tag("Gallery")
             */
            
            AboutUs()
                .tag("About Us")
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
