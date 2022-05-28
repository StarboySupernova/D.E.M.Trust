//
//  UserProfileView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/20/22.
//

import SwiftUI

struct UserProfileView: View {
    @State private var isShowingPhotoPicker: Bool = false
    @State private var avatar = UIImage(named: "usericon")! //will need to upload this to firestore
    var body: some View {
        VStack {
            Image(uiImage: avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .background(
                    Color.topBG
                        .cornerRadius(15, corners: [.topLeft, .bottomRight])
                )
                .padding()
                .onTapGesture {
                    isShowingPhotoPicker = true
                }
            
            Spacer()
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(avatar: $avatar)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
            .preferredColorScheme(.dark)
    }
}
