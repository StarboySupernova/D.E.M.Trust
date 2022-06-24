//
//  SideMenu.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/23/22.
//

import SwiftUI

struct SideMenu: View {
    @Binding var selectedTab: String
    @Namespace var animation
    @State private var showUserProfile: Bool = false
    @State private var userName: String = "USERNAME"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            //profile picture
            Image("romeo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 70, height: 70)
                .cornerRadius(10)
            //top padding for top close button
                .padding(.top, 50)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Romeo Chingezi") //user name comes here
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .shadow(radius: 10) //use glow from neumorphism
                    .glow(color: .blue.opacity(0.2), radius: 1)
                    .multilineTextAlignment(.leading)
                
                Button {
                    //use LandingView to present profile page to be created. UserDefaults to store user info
                    showUserProfile = true
                } label: {
                    Text("View Profile")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .opacity(0.7)
                }
                .sheet(isPresented: $showUserProfile, content: {
                    UserProfileView(showUserProfile: $showUserProfile, userName: $userName)
                })
                .onTapGesture {
                    showUserProfile = true
                }
            }
            
            //tab buttons
            VStack(alignment: .leading, spacing: 10) {
                TabButton(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "globe.europe.africa.fill", title: "Operations", selectedTab: $selectedTab, animation: animation)
                TabButton(image: "brain.head.profile", title: "Training", selectedTab: $selectedTab, animation: animation)
                /*//removing videoplayerview from tab view to avoid the behaviour tab view adopts when it has more than five children
                 TabButton(image: "play.tv.fill", title: "Documentaries", selectedTab: $selectedTab, animation: animation)
                 */
                TabButton(image: "paperplane.circle.fill", title: "Messaging", selectedTab: $selectedTab, animation: animation)
                /*//removing galleryview from tab view to avoid the behaviour tab view adopts when it has more than five children
                 TabButton(image: "camera.viewfinder", title: "Gallery", selectedTab: $selectedTab, animation: animation)
                 */
                TabButton(image: "person.3.fill", title: "About Us", selectedTab: $selectedTab, animation: animation)
                
            }
            .padding(.leading, -15)
            .padding(.top, 50)
            
            Spacer()
            
            //Sign out button
            VStack(alignment: .leading, spacing: 6) {
                TabButton(image: "rectangle.lefthalf.inset.fill.arrow.left", title: "Logout", selectedTab: .constant(""), animation: animation)
                    .padding(.leading, -15)
                
                Text("App version 1.2.17")
                    .font(.caption)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .opacity(0.6)
                    .padding(.bottom, 10)
            }
        }
        .padding()
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .topLeading)

    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ModelData())
    }
}
