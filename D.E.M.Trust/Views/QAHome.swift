//
//  QAHome.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/17/22.
//

import SwiftUI

struct QAHome: View {
    //might make into viewbuilder function
    @State private var show: Bool = false
    //storing level for fetching questions
    @State private var set = "Exam_1"
    
    @State private var correct = 0
    @State private var incorrect = 0
    @State private var attempted = 0
    
    var body: some View {
        VStack {
            Text("D.E.M.T. Learning")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.topBG)
                .padding(.top)
            
            Spacer(minLength: 0)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35) {
                
                ForEach(1...4, id: \.self) { index in
                    /*
                     extending Int to conform to Identifiable producing unexpected behaviour here when id is \.self.id. Same behaviour produced when id parameter is omitted entirely
                     */
                    VStack(spacing: 15) {
                        Image("astronaut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 150)
                        
                        Text("D.E.M.T. Learning")
                            .foregroundColor(.black)
                            .font(.headline)
                            .fontWeight(.heavy)
                        
                        Text("Level \(index)")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .onTapGesture {
                        set = "Round\(index)"
                        show.toggle()
                    }
                }
                
            }
            .padding()
            
            Spacer(minLength: 0)
        }
        .background(
            Color.black.opacity(0.05)
                .ignoresSafeArea()
        )
        .sheet(isPresented: $show) {
            QAView(correctAnswers: $correct, incorrectAnswers: $incorrect, attempted: $attempted, set: set)
        }
    }
}

struct QAHome_Previews: PreviewProvider {
    static var previews: some View {
        QAHome()
            .preferredColorScheme(.dark)
    }
}
