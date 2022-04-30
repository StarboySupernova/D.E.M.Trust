//
//  LandingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/23/22.
//

import SwiftUI

struct LandingView: View {
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
            // PlaylistView()
            //   .tag("My Playlists")
            // HistoryWrappingView()
            //   .tag("History")
            
        }
    }
}


struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
