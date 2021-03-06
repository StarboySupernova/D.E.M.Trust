//
//  QuestionComponent.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/15/22.
//

import SwiftUI

struct QuestionComponent: View {
    @State private var index: Int = 1
    @State private var title: String?
    @State private var subtitle: String?
    var animation: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            //to be shared across the start and the end of the animation
            VStack(alignment: .leading, spacing: 12) {
                Text(title ?? "D.E.M.T. Learning")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .matchedGeometryEffect(id: "title", in: animation) //nb: integrity before modifier
                    .frame(maxWidth: .infinity, alignment: .leading) //positioning after modifier
                
                Text(subtitle?.uppercased() ?? "20 questions - Level: Easy".uppercased())
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)
                    .matchedGeometryEffect(id: "subtitle", in: animation)
            }
            .matchedGeometryEffect(id: "blur", in: animation)
            .padding(20)
            
            Text("Tap to Begin")
                .font(.footnote)
                .matchedGeometryEffect(id: "question", in: animation)
        }
        .padding()
        .foregroundStyle(.white)
        .background(
            ZStack {
                Image("demtJacket")
                    .resizable()
                    .clipShape(Circle())
                Color.topBG.opacity(0.1)
                    .matchedGeometryEffect(id: "background", in: animation)
            }
        )
        .mask({
            Rectangle()
                .cornerRadius(15, corners: [.topRight, .bottomLeft])
                .matchedGeometryEffect(id: "mask", in: animation)
        })
        .frame(height: 250)
        .padding(.horizontal, 20)
    }
}

struct QuestionComponent_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        QuestionComponent(animation: animation, show: .constant(true))
            .preferredColorScheme(.dark)
    }
}
