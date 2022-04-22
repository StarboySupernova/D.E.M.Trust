//
//  LaunchPoint.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/19/22.
//

import SwiftUI

struct LaunchPoint: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @Environment(\.verticalSizeClass) var verticalSizeClass: UserInterfaceSizeClass?
    
    //Liquid Swipe offset
    @State private var offset: CGSize = .zero
    @State private var showHome: Bool = false
    //Animation properties
    @State private var scale: Bool = false
    @State private var showBanner: Bool = false
    @State private var showViews: [Bool] = Array(repeating: false, count: 5)
    
    var body: some View {
        Group {
            if verticalSizeClass == .regular && horizontalSizeClass == .compact {
                ZStack {
                    Background()
                        .cornerRadius(15, corners: .topRight)
                        .overlay(
                            //content here
                            VStack {
                                
                            }
                        ) //comes before clipping to ensure it gets erased when user drags animation over it
                        .clipShape(LiquidSwipe(showHome: $showHome, offset: offset))
                        .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
                        .overlay (
                            //withanimation and delay here
                            HStack(spacing: 0) {
                                Text("Please Swipe")
                                    .foregroundColor(.primary)
                                    .font(.callout)
                                    .fontWeight(.light)
                                    .scaleEffect(scale ? 1 : 0.7)
                                    .onAppear {
                                        withAnimation(.easeOut.delay(0.1)) {
                                            scale.toggle()
                                        }
                                    }
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
                                                offset.width = -screen.height * 2
                                                showHome.toggle()
                                            } else {
                                                offset = .zero
                                            }
                                        }
                                    }))
                            }
                                .opacity(offset == .zero ? 1 : 0)
                            
                            ,alignment: .topTrailing
                        )
                        .padding(.trailing, 30)
                    
                    if showBanner {
                        BannerView()
                            .opacity(showHome ? 0 : 1)
                    }
                    
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
                .onAppear {
                    withAnimation(.spring()) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showBanner = true
                        }
                    }
                }
            } else {
                ZStack {
                    if showHome == false {
                        Background()
                            .opacity(0.5)
                            .cornerRadius(25, corners: .topRight)
                            .overlay(
                                //content here
                                VStack {
                                    
                                }
                            ) //comes before clipping to ensure it gets erased when user drags animation over it
                            .edgesIgnoringSafeArea([.bottom, .trailing])
                            .overlay (
                                Image(systemName: "chevron.right.circle")
                                    .font(.largeTitle)
                                    .foregroundColor(.primary)
                                    .frame(width: 90, height: 70)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        showHome.toggle()
                                    }
                                    .opacity(showHome ? 0 : 1)
                                
                                ,alignment: .topTrailing
                                
                            )
                            .padding(.trailing, UIScreen.main.bounds.width * 0.1)
                        
                        if showBanner {
                            VStack {
                                Spacer()
                                BannerView()
                                    .opacity(showHome ? 0 : 1)
                                    .padding(.trailing, 20)
                            }
                        }
                    } else {
                        if showHome {
                            Text("Welcome")
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        showHome = false
                                    }
                                }
                        }
                        
                    }
                    
                }
                .onAppear {
                    withAnimation(.spring()) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            showBanner = true
                        }
                    }
                }
            }
        }
    }
}

struct LaunchPoint_Previews: PreviewProvider {
    static var previews: some View {
        LaunchPoint()
            .preferredColorScheme(.dark)
    }
}

struct BannerView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .bottom) {
                Image("DEMTLogo")
                    .resizedToFill(width: 200, height: 200)
                    .cornerRadius(10, corners: .allCorners)
                    .cornerRadius(30, corners: [.topLeft, .bottomRight])
                
                Text("Disaster and Environmental Management Trust")
                    .foregroundColor(.primary)
                    .font(.system(size: 20, design: .rounded))
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}
