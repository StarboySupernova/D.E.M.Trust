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
    
    var body: some View {
        VStack {
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                Capsule()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 6)
                
                Capsule()
                    .fill(Color.green)
                    .frame(width: 100, height: 6)
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
            
            Spacer(minLength: 0)
        }
        .onAppear {
            data.getQuestions(set: set)
        }
    }
    
    struct QAView_Previews: PreviewProvider {
        static var previews: some View {
            QAHome()
        }
    }
}
