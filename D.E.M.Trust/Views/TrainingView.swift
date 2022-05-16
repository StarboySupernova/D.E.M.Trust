//
//  TrainingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/1/22.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var scrollToEnd: Bool = false
    @State private var progress: CGFloat = 0
    @State private var animateGradient: Bool = false
    @Namespace private var animation
    @State private var show: Bool = false
    
    let gradient = Gradient(stops: [Gradient.Stop(color: .white, location: 0.1), Gradient.Stop(color: .bottomBG, location: 0.8)])
    
    /*
     let backgroundGradient = Gradient(colors: [.darkStart, .bottomBG])
     let backgroundGradient2 = Gradient(colors: [.darkEnd, .topBG])
     */
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.topBG.opacity(0.7), .bottomBG.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 5) {
                        if show {
                            QuestionDetailView(animation: animation, show: $show)
                        }
                        
                        if !show {
                            ScrollViewReader { scrollView in
                                ScrollView(horizontalSizeClass == .compact ? .horizontal : .init(), showsIndicators: false) {
                                    Button {
                                        if scrollToEnd == false {
                                            withAnimation(.spring()) {
                                                scrollView.scrollTo(3)
                                            }
                                            
                                            scrollToEnd = true
                                        }
                                    } label: {
                                        Image(systemName: "chevron.right")
                                            .resizedToFit(width: 35, height: 30)
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(
                                                Ellipse()
                                                    .stroke(.white, style: StrokeStyle())
                                                    .background(Ellipse().fill(.orange))
                                            )
                                    }
                                    .opacity(scrollToEnd ? 0 : 1)
                                    .frame(width: 60, height: 60)
                                    .offset(x: getRect().width < 400 ? -25 : 5)
                                    
                                    HStack {
                                        //can make array of tiles in future, for better modularity
                                        tile(title: "Learn to take care of your environment", "welcomingtree")
                                            .id(0)
                                        tile(title: "Engaging with the grassroots community")
                                            .id(1)
                                        tile(title: "Discovering disaster prevention", "throughpark")
                                            .id(2)
                                        tile(title: "Leveraging modern technologies", "signalsearching")
                                            .id(3)
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .circular)
                                            .fill(Color.bottomBG)
                                            .padding()
                                            .padding(.bottom, 20)
                                    )
                                }
                            }
                            
                            Text("Courses".uppercased())
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                            
                            QuestionComponent(animation: animation, show: $show)
                                .onTapGesture {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        show.toggle()
                                    }
                                }
                        }
                        
                    }
                }
            }
            
        }
        
        /*
         .animatableGradient(fromGradient: backgroundGradient, toGradient: backgroundGradient2, progress: progress)
         .onAppear {
         withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
         self.progress = 1.0
         }
         }
         */
    }
    
    @ViewBuilder
    func tile(title: String, _ imageName: String = "people") -> some View {
        ZStack (alignment: .top) {
            Color.bottomBG
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 200)
                .cornerRadius(35, corners: [.bottomRight])
            VStack(spacing: 20) {
                Spacer()
                Text(title + "\n")
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(-90), endAngle: .degrees(0)))
                            .padding(.vertical, -15)
                    )
            }
        }
        .frame(width: 150, height: 275)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
            .preferredColorScheme(.dark)
    }
}
