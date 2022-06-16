//
//  ConversationView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/16/22.
//

import SwiftUI

struct ConversationView: View {
    @StateObject var messagesManager = MessagesManager()
    var body: some View {
        VStack {
            VStack {
                TitleRow()
                
                ScrollViewReader { scroll in
                    ScrollView {
                        ForEach(messagesManager.messages) { message in
                            MessageBubble(message: message)
                        }
                    }
                    .padding(.top, 10)
                    .background(Color("unicorn").opacity(0.7))
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                    .onChange(of: messagesManager.lastMessageID) { id in
                        withAnimation {
                            scroll.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
            }
            .background(LinearGradient(mycolors: .darkEnd, Color("unicorn")))
            
            MessageField()
                .environmentObject(messagesManager)
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView()
            .preferredColorScheme(.dark)
    }
}
