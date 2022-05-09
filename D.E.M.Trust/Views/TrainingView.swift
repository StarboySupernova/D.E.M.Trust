//
//  TrainingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/1/22.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var scrollEnd: Bool = false
    
    let gradient = Gradient(stops: [Gradient.Stop(color: .white, location: 0.1), Gradient.Stop(color: .bottomBG, location: 0.8)])
    
    var body: some View {
        ZStack {
            Image("liquid-cheese")
                .resizable()
                .overlay {
                    Color.black.opacity(0.7)
                }
            VStack {
                ScrollViewReader { scrollView in
                    ScrollView(horizontalSizeClass == .compact ? .horizontal : .init()) {
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
                        .overlay(content: {
                            ZStack {
                                Button {
                                    if scrollEnd == false {
                                        withAnimation(.spring()) {
                                            scrollView.scrollTo(3)
                                        }
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            scrollEnd = true
                                        }
                                    }
                                } label: {
                                    Image(systemName: "arrow.right")
                                        .resizedToFill(width: 35, height: 30)
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(
                                            Ellipse()
                                                .fill(.green)
                                        )
                                }
                                .offset(x: -25)
                                .opacity(scrollEnd ? 0 : 1)
                            }
                        })
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 15, style: .circular)
                                .fill(Color.bottomBG)
                                .padding()
                                .padding(.bottom, 20)
                        )
                    }
                }
                Spacer()
            }
            
        }
        .onAppear {
            scrollEnd = false
        }

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
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(-90), endAngle: .degrees(0)))
                            /*
                             //might be useful
                             .fill(LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: .bottomBG, location: 0.1),
                                Gradient.Stop(color: .white, location: 0.2),
                                Gradient.Stop(color: .white, location: 0.9)
                            ]), startPoint: .topTrailing, endPoint: .bottomLeading))
                             */
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
    }
}
