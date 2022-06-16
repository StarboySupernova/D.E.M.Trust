//
//  ConversationView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/16/22.
//

import SwiftUI

struct ConversationView: View {
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollView {
                    
                }
                .padding(.top, 10)
                .background(Color("unicorn").opacity(0.7))
                .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            .background(LinearGradient(mycolors: .darkEnd, Color("unicorn")))
            
            MessageField()
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
            .preferredColorScheme(.dark)
    }
}
