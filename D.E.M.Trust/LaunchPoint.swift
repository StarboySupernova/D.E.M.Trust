//
//  LaunchPoint.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/19/22.
//

import SwiftUI

struct LaunchPoint: View {
    var body: some View {
        Heim()
    }
}

struct LaunchPoint_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPoint()
    }
}

struct Heim: View {
    //Liquid Swipe offset
    @State private var offset: CGSize = .zero
    @State private var showHome: Bool = false
    var body: some View {
        ZStack {
            Color.blue
                .cornerRadius(15, corners: .topRight)
                .overlay(
                    //content here
                    VStack {
                        
                    }
                ) //comes before clipping to ensure it gets erased when user drags animation over it
                .clipShape(LiquidSwipe(showHome: $showHome, offset: offset))
                .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                .overlay (
                    Image(systemName: "chevron.left")
                        .font(.largeTitle)
                    //drag gesture identification
                        .frame(width: 50, height: 50)
                        .contentShape(Rectangle())
                        .gesture(DragGesture().onChanged({ value in
                            //animating swipe offset
                            withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.6)) {
                                offset = value.translation
                            }
                        }).onEnded({ value in
                            let screen = UIScreen.main.bounds
                            withAnimation(.spring()) {
                                if -offset.width > screen.width / 2 {
                                    offset.width = -screen.height
                                    showHome.toggle()
                                } else {
                                    offset = .zero
                                }
                            }
                        }))
                        .offset(x: getRect().width * 0.015, y: getRect().height * 0.065)
                        .opacity(offset == .zero ? 1 : 0)
                    
                    ,alignment: .topTrailing
                    
                )
                .padding(.trailing)
            
            if showHome {
                Text("Welcome")
                    .onTapGesture {
                        withAnimation(.spring()) {
                            offset = .zero
                            showHome.toggle()
                        }
                    }
            }
        }
    }
}

//custom shape

struct LiquidSwipe: Shape {
    @Binding var showHome: Bool //makes this useful in this file only
    //getting offset size
    var offset: CGSize
    //animating path
    var animatableData: CGSize.AnimatableData {
        get {
            return offset.animatableData
        }
        set {
            offset.animatableData = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            //first, constructing a rectangle shape
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            //constructing curve shape
            //from
            let from = getRect().height * 0.05 + (offset.width) //for liquid effect
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            //to
            var to = getRect().height * 0.2 + (offset.height) + (-offset.width) //also adding height
            to = to < 180 ? 180 : to
            
            let mid: CGFloat = getRect().width * 0.1 + ((to - 180) / 2)
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - getRect().width * 0.1, y: mid), control2: CGPoint(x: width - getRect().width * 0.1, y: mid))
        }
    }
}
