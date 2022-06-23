//
//  HeroPageView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/23/22.
//

import SwiftUI

struct HeroPageView: View {
    @State private var moving = false
    @State private var showBanner: Bool = false
    @State private var showHome: Bool = false
    @State private var progress: CGFloat = 0
    
    let backgroundGradient = Gradient(colors: [.darkStart.opacity(0.1), .bottomBG.opacity(0.1)])
    let backgroundGradient2 = Gradient(colors: [.darkEnd.opacity(0.1), .topBG.opacity(0.1)])
    
    var body: some View {
        Group {
            if showHome {
                MainView()
            } else {
                ZStack(alignment: .center) {
                    Rectangle()
                        .animatableGradient(fromGradient: backgroundGradient, toGradient: backgroundGradient2, progress: progress)
                        .ignoresSafeArea()
                        .onAppear {
                            withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                                self.progress = 1.0
                            }
                        }
                    
                    Circle() // One
                        .stroke(lineWidth: 5)
                        .frame(width: 20, height: 20)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true), value: moving)
                    
                    Circle()  // Two
                        .stroke(lineWidth: 4)
                        .frame(width: 50, height: 50)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.05), value: moving)
                    
                    Circle()  // Three
                        .stroke(lineWidth: 3)
                        .frame(width: 80, height: 80)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.1), value: moving)
                    
                    Circle()  // Four
                        .stroke(lineWidth: 3)
                        .frame(width: 110, height: 110)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.15), value: moving)
                    
                    Circle()  // Five
                        .stroke(lineWidth: 2)
                        .frame(width: 140, height: 140)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.2), value: moving)
                    
                    Circle()  // Six
                        .stroke(lineWidth: 2)
                        .frame(width: 170, height: 170)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.25), value: moving)
                    
                    Circle()  // Seven
                        .stroke(lineWidth: 1)
                        .frame(width: 200, height: 200)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.3), value: moving)
                    
                    Circle()  // Eight
                        .stroke(lineWidth: 1)
                        .frame(width: 230, height: 230)
                        .rotation3DEffect(.degrees(75), axis: (x: 1, y: 0, z: 0))
                        .offset(y: moving ? 0 : -getRect().height * 0.25)
                        .animation(.interpolatingSpring(stiffness: 100, damping: 5).repeatForever(autoreverses: true).delay(0.35), value: moving)
                    
                    Group {
                        if showBanner {
                            BannerView(showHome: $showHome)
                                .transition(AnyTransition.slide)
                        }
                    }
                    .animation(.easeInOut, value: showBanner)
                }
                .foregroundStyle(LinearGradient(mycolors: .customOrange, .bottomBG, .topBG))
                .onAppear{
                    moving.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        showBanner = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        withAnimation(.easeInOut) {
                            showHome = true
                        }
                    }
                }
            }
        }
    }
    
}

struct HeroPageView_Previews: PreviewProvider {
    static var previews: some View {
        HeroPageView()
            .environmentObject(ModelData())
            .preferredColorScheme(.dark)
    }
}

struct BannerView: View {
    @Binding var showHome: Bool
    var body: some View {
        VStack(alignment: .center) {
            HStack(alignment: .bottom) {
                Image("demtLogo")
                //.resizedToFill(width: 200, height: 200)
                    .resizable()
                    .clipShape(Ellipse())
                    .frame(width: 170, height: 130)
                    .glow(color: .green, radius: 2)
                //.cornerRadius(10, corners: .allCorners)
                //.cornerRadius(30, corners: [.topLeft, .bottomRight])
                
                Text("Disaster and \nEnvironmental Management\n Trust")
                    .foregroundColor(.primary)
                    .font(.system(size: 20, design: .rounded))
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: getRect().height * 0.3)
            .padding(.bottom, 5)
            
            LabelledDivider(label: "", horizontalPadding: 0, color: .white)
                .padding(.bottom, 5)
            
            Button {
                showHome = true
            } label: {
                Text("Continue")
                    .foregroundColor(.white)
                    .glow(color: .green.opacity(0.2), radius: 5)
            }
            .padding(10)
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.topBG.opacity(0.3))
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}


