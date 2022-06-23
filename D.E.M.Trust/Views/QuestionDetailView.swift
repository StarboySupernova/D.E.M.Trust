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
    //storing exam id for fetching questions from Firestore
    @State private var set = "Exam_1"
    
    @State private var correct = 0
    @State private var incorrect = 0
    @State private var attempted = 0
    
    @State private var overlay: Bool = true
    @State private var backgroundOverlay: Bool = true
    
    
    var body: some View {
        ScrollView {
            VStack {
                ScrollView {
                    QAView(correctAnswers: $correct, incorrectAnswers: $incorrect, attempted: $attempted, set: set, show: $show)
                        .matchedGeometryEffect(id: "question", in: animation)
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: getRect().height * 0.95)
            .padding(20)
            .foregroundStyle(.black)
            .background(
                ZStack {
                    Color("unicorn")
                    
                    Image("launch")
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .opacity(0.9)
                }
                    .matchedGeometryEffect(id: "background", in: animation)
            )
            .mask({
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .matchedGeometryEffect(id: "mask", in: animation)
            })
            .overlay {
                if overlay == true {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Community Learnerships")
                            .font(.footnote)
                        Divider()
                        HStack {
                            Image("demtLogo")
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
                    .background {
                        if backgroundOverlay == true {
                            ZStack {
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                                    .mask(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .blur(radius: 20)
                            }
                            .matchedGeometryEffect(id: "blur", in: animation)
                        }
                    }
                    .offset(y: getRect().height * 0.3)
                    .padding(20)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    backgroundOverlay = false
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    overlay = false
                }
            }
        }
        
    }
}

struct QuestionDetailView_Previews: PreviewProvider {
    @Namespace static var animation
    
    static var previews: some View {
        QuestionDetailView(animation: animation, show: .constant(true))
            .preferredColorScheme(.dark)
    }
}
