//
//  MessageBubble.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/16/22.
//

import SwiftUI

struct MessageBubble: View {
    @State private var showTime: Bool = true
    var message: Message
    
    var body: some View {
        VStack(alignment: message.receiver ? .leading : .trailing) {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.receiver ?  Color.topBG : Color.customOrange)
                    .cornerRadius(30, corners: message.receiver ? [.topRight, .bottomLeft, .bottomRight] : [.topLeft, .topRight, .bottomLeft])
                    .multilineTextAlignment(message.receiver ? .leading : .trailing)
                    .frame(maxWidth: getRect().width * 0.8, alignment: message.receiver ? .leading : .trailing)
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.55)) {
                    showTime.toggle()
                }
            }
            
            if showTime && message.timestamp < Date().addingTimeInterval(-86400) {
                Text(message.timestamp.formatted(.dateTime.day().month().year().hour().minute()))
            } else if showTime {
                Text(message.timestamp.formatted(.dateTime.hour().minute()))
                    .font(.caption)
                    .foregroundColor(.offWhite)
                    .padding(message.receiver ? .trailing : .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: message.receiver ? .leading : .trailing)
        .padding(message.receiver ? .leading : .trailing)
        .padding(.horizontal, 5)
    }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(message: Message(text: "Hello", receiver: false, timestamp: Date()))
            .preferredColorScheme(.dark)
    }
}
