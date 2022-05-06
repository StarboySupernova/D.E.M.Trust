//
//  Background.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/21/22.
//

import SwiftUI

struct Background: View {
    var body: some View {
        ZStack {
            LinearGradient(mycolors: Color.darkStart, Color.darkEnd, Color.black)

            VStack {
                Circle()
                    .fill(Color.green)
                    .scaleEffect(0.6)
                    .offset(x: 20)
                    .blur(radius: 120)
                
                Circle()
                    .fill(Color.green)
                    .scaleEffect(0.6, anchor: .leading)
                    .offset(y: -20)
                    .blur(radius: 120)

            }
                                    
            Rectangle()
                .fill(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
