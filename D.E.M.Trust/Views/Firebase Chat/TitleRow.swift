//
//  TitleRow.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/16/22.
//

import SwiftUI

struct TitleRow: View {
    var imageURL = URL(string: "") //will get this from Firebase
    var name: String = "" //will get this from Firebase
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageURL) {image in
                image
                    .resizedToFill(width: 50, height: 50)
                    .cornerRadius(20)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2.bold())
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.customOrange)
                
               /* Text(room.name)
                    .font(.caption)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.offWhite)
                
                Text(room.description)
                    .font(.caption2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white) */
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
    }
}

struct TitleRow_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
    }
}
