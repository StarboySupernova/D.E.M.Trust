//
//  QAView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/17/22.
//

import SwiftUI

struct QAView: View {
    @Binding var correctAnswers: Int
    @Binding var incorrectAnswers: Int
    @Binding var attempted: Int
    var set: String
    @StateObject var data = QuestionViewModel()
    @Environment(\.presentationMode) var presentationMode
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            if data.questions.isEmpty {
                VStack{} //should create appwide error view. NB:this conditional makes it safe to force unwrap in QuestionView
            } else {
                if attempted == data.questions.count {
                    //should make into own view
                    VStack {
                        Image("completed")
                            .resizedToFit(width: 250, height: 250)
                        
                        Text("Well Done !")
                            .foregroundColor(.white)
                            .font(.body)
                            .fontWeight(.heavy)
                        
                        HStack(spacing: 15) {
                            Image(systemName: "checkmark")
                                .font(.largeTitle)
                                .foregroundColor(.green)
                            
                            Text("100 %") //to be fixed - most likely .2f notation
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                        }
                        
                        Button {
                            presentationMode.wrappedValue.dismiss()
                            show = false
                        } label: {
                            Text("Back")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: getRect().width - 150)
                                .background(Color.red)
                                .cornerRadius(15)
                        }

                    }
                } else {
                    VStack {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.green)
                                .frame(width: progression(), height: 6)
                        }
                        .padding()
                        
                        HStack {
                            Label {
                                Text(correctAnswers == 0 ? "" : "\(correctAnswers)")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            } icon: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.green)
                                    .font(.largeTitle)
                            }
                            
                            Spacer()
                            
                            Label {
                                Text(incorrectAnswers == 0 ? "" : "\(incorrectAnswers)")
                                    .font(.largeTitle)
                                    .foregroundColor(.black)
                            } icon: {
                                Image(systemName: "xmark")
                                    .foregroundColor(.red)
                                    .font(.largeTitle)
                            }
                            
                        }
                        .padding()
                        
                        //QuestionView - might use already extant code in QuestionDetailView
                        ZStack {
                            ForEach(data.questions.reversed().indices, id: \.self){ index in
                                QuestionView(question: $data.questions[index], correct: $correctAnswers, incorrect: $incorrectAnswers, attempted: $attempted)
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            data.getQuestions(set: set)
        }
    }
    
    func progression() -> CGFloat {
        let fraction = CGFloat(attempted) / CGFloat(data.questions.count)
        let width = (getRect().width) - 30
        return fraction * width
    }
    
    struct QAView_Previews: PreviewProvider {
        static var previews: some View {
            QAHome()
        }
    }
    
    
}
