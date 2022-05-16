//
//  QuestionDetailView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/15/22.
//

import SwiftUI

struct QuestionDetailView: View {
    var animation: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Next")
                            .font(.footnote)
                            .foregroundColor(.white)
                            .padding(8)
                            .background(.ultraThinMaterial, in: Capsule())
                    }
                }
                
                ScrollView {
                    Text("Exam Question")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .matchedGeometryEffect(id: "question", in: animation)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: getRect().height * 0.85)
            .padding(20)
            .foregroundStyle(.black)
            .background(
                Color.topBG
                    .matchedGeometryEffect(id: "background", in: animation)
            )
            .mask({
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: animation)
            })
            .overlay(
                VStack(alignment: .leading, spacing: 12) {
                    Text("20 sections - 3 hours".uppercased())
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .matchedGeometryEffect(id: "subtitle", in: animation)
                    
                    Text("Swift")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "title", in: animation)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    HStack {
                        Image("DEMTLogo")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                        
                        VStack {
                            Text("D.E.M.T.")
                                .font(.footnote)
                            Text("Making a difference")
                                .font(.caption2)
                        }
                    }
                }
                .padding(20)
                .background(
                    ZStack {
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .blur(radius: 20)
                    }
                    .matchedGeometryEffect(id: "blur", in: animation)
                )
                .offset(y: getRect().height * 0.3)
                .padding(20)
            )
        }

    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        QuestionDetailView(animation: animation, show: .constant(true))
    }
}
