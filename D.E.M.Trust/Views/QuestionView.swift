//
//  QuestionView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/18/22.
//

//temporary view
import SwiftUI

struct QuestionView: View {
    @Binding var question: Question
    @Binding var correct: Int
    @Binding var incorrect: Int
    @Binding var attempted: Int
    @State var selected = ""
    
    var body: some View {
        VStack(spacing: 15) {
            Text(question.question ?? "An error occured while retrieving the question")
                .font(.title2)
                .foregroundColor(.white)
                .fontWeight(.heavy)
                .padding(.top, 25)
            
            Spacer(minLength: 0)
            
            Button {
                selected = question.optionA ?? "" //ahould find more elegant solution here
            } label: {
                Text(question.optionA ?? "An error occurred retrieving the data") //should deal with multilinetext alignment, then extract button to own file. Should probably create button group with my buttons
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(highlightColor(option: question.optionA ?? "error"), lineWidth: 1)
                    )
            }
            
            Button {
                selected = question.optionB ?? "" //ahould find more elegant solution here
            } label: {
                Text(question.optionB ?? "An error occurred retrieving the data")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(highlightColor(option: question.optionB ?? "error"), lineWidth: 1)
                    )
            }

            Button {
                selected = question.optionC ?? "" //ahould find more elegant solution here
            } label: {
                Text(question.optionC ?? "An error occurred retrieving the data")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(highlightColor(option: question.optionC ?? "error"), lineWidth: 1)
                    )
            }

            Spacer(minLength: 0)
            
            HStack(spacing: 15) {
                Button {
                    checkAnswer()
                } label: {
                    Text("Submit")
                        .font(.footnote)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        //.padding(.vertical)
                        .frame(maxWidth: .infinity)
                        //.background(.ultraThinMaterial, in: Capsule())
                        .modifier(ConvexGlassView())
                }
                .disabled(question.isSubmitted ? true : false)
                .opacity(question.isSubmitted ? 0.2 : 1)
                
                Button {
                    withAnimation(.spring()) {
                        question.completed.toggle()
                        attempted += 1
                    }
                } label: {
                    Label {
                        if !question.isSubmitted {
                            EmptyView()
                        } else {
                            Image(systemName: "arrowshape.bounce.right")
                                .font(.body)
                                .foregroundColor(.orange)
                        }
                    } icon: {
                        Text("Next")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            //.padding(.vertical)
                    }
                    .frame(maxWidth: .infinity)
                    //.background(.ultraThinMaterial, in: Capsule())
                    .modifier(ConvexGlassView())
                }
                .disabled(!question.isSubmitted ? true : false)
                .opacity(!question.isSubmitted ? 0.2 : 1)
            }
            .padding(.bottom)
        }
        .padding()
        .background(Background())
        .foregroundColor(Color.primary.opacity(0.35))
        .foregroundStyle(.ultraThinMaterial)
        .cornerRadius(25)
    }
    
    //highlighting answer
    func highlightColor(option: String) -> Color {
        if option == selected {
            if question.isSubmitted {
                if selected == question.answer! {
                    return Color.green
                } else {
                    return Color.red
                }
            } else {
                return Color.blue
            }
        } else {
            
            if question.isSubmitted && option != selected {
                if question.answer! == option {return Color.green}
            }
            return Color.gray
        }
    }
    
    func checkAnswer() {
        /*if question.answer == nil {
            //emit error here
        }*/
        if selected == question.answer! {
            correct += 1
        } else {
            incorrect += 1
        }
        
        question.isSubmitted.toggle()
    }
    
    /*
     returning different labelstyles based on Boolean condition. Use of ternary conditional operator in built-in labelstyle(_:) function emits an error
    func conditionalLabelStyle(_ condition: Bool) -> LabelStyle.Configuration {
        if condition {
            return IconOnlyLabelStyle()
        } else {
            return TitleAndIconLabelStyle()
        }
    }
     */
    
}

