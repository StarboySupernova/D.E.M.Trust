//
//  ExamQuestionView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/5/22.
//

import SwiftUI

struct ExamQuestionView: View {
    @Namespace private var animation
    @State private var show: Bool = false
    
    var body: some View {
        ZStack {
            if !show {
                VStack(alignment: .leading, spacing: 20) {
                    //to be shared across the start and the end of the animation
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Swift")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "title", in: animation) //nb: integrity before modifier
                            .frame(maxWidth: .infinity, alignment: .leading) //positioning after modifier
                        
                        Text("20 sections - 3 hours".uppercased())
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .matchedGeometryEffect(id: "subtitle", in: animation)
                    }
                    .matchedGeometryEffect(id: "blur", in: animation)
                    .padding(20)
                    
                    Text("Exam Question")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "question", in: animation)
                }
                .padding()
                .foregroundStyle(.white)
                .background(
                    Color.darkStart
                        .matchedGeometryEffect(id: "background", in: animation)
                )
                .mask({
                    Rectangle()
                        .cornerRadius(15, corners: [.topRight, .bottomLeft])
                        .matchedGeometryEffect(id: "mask", in: animation)
                })
                .frame(height: 300)
                .padding(20)
                
            } else {
                ScrollView {
                    VStack {
                        ScrollView {
                            Text("Exam Question")
                                .multilineTextAlignment(.center)
                                .font(.body)
                                .matchedGeometryEffect(id: "question", in: animation)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: getRect().height * 0.8)
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
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

struct ExamQuestionView_Previews: PreviewProvider {
    static var previews: some View {
        ExamQuestionView()
    }
}
