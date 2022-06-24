//
//  MainView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/23/22.
//

import SwiftUI

struct MainView: View {
    //selected tab
    @State private var selectedTab: String = "Home"
    @State private var showMenu: Bool = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            LinearGradient(mycolors: Color.darkStart,Color.darkEnd)
                .ignoresSafeArea()
            
            //Side Menu
            if showMenu {
                ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false) {
                    SideMenu(selectedTab: $selectedTab)
                }
                .frame(maxWidth: getRect().width * 0.7)
            }
            
            ZStack {
                //2 background cards
                Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -25 : 0)
                    .padding(.vertical, 30)
                
                Color.white
                    .opacity(0.4)
                    .cornerRadius(showMenu ? 15 : 0)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: -5, y: 0)
                    .offset(x: showMenu ? -50 : 0)
                    .padding(.vertical, 60)
                
                LandingView(selectedTab: $selectedTab)
                    .cornerRadius(showMenu ? 20 : 0)
                
            }
            //Scaling and moving the view
            .scaleEffect(showMenu ? 0.84 : 1)
            .offset(x: showMenu ? getRect().width - 120 : 0)
            .ignoresSafeArea()
            .overlay (
                //menu button
                Button {
                    withAnimation(.spring()) {
                        showMenu.toggle()
                    }
                } label: {
                    //Animated drawer button
                    VStack(spacing: 5) {
                        Capsule()
                            .fill(showMenu ? Color.white : Color.green)
                            .frame(width: 30, height: 3)
                            .rotationEffect(.init(degrees: showMenu ? -49.9 : 0.01))
                            .offset(x: showMenu ? 2 : 0, y: showMenu ? 9 : 0)
                        VStack(spacing: 5) {
                            Capsule()
                                .fill(showMenu ? Color.white : Color.green)
                                .frame(width: 30, height: 3)
                            //moving up when clicked
                            Capsule()
                                .fill(showMenu ? Color.white : Color.green)
                                .frame(width: 30, height: 3)
                                .offset(y: showMenu ? -8 : 0)
                        }
                        .rotationEffect(.init(degrees: showMenu ? 49.9 : 0.9))
                    }
                    .shadow(color: .black.opacity(0.5), radius: 20, x: 0, y: 0)
                    .glow(color: .black.opacity(0.5), radius: 2)
                }
                    .padding() //useful to learn to detect which phones have a notch here
                
                ,alignment: .topLeading
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}
