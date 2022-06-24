//
//  AboutUs.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/17/22.
//

import SwiftUI

struct AboutUs: View {
    @State private var posts: [Post] = projects
    //Custom scroller properties
    @State private var currentIndex: Int = 0
    @State private var currentPost: Post = projects[0]
    @State private var lineLimit: Int = 4
    
    var body: some View {
        VStack(spacing: 0) {
            Text(titleString)
                .font(.body)
                .fontWeight(.ultraLight)
                .multilineTextAlignment(.trailing)
                .lineLimit(lineLimit)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        withAnimation(.easeInOut.delay(1)) {
                            lineLimit = 1
                        }
                    }
                }
            
            //MARK: Custom scroller
            VStack {
                customScroller()
                    .zIndex(1)
                standView
                    .zIndex(0)
            }
            .padding(.horizontal, -15)
            .zIndex(1)
            
            TabView {
                ForEach($posts) { $post in
                    ProjectCardView(post: post)
                        .offsetX { value, width in
                            if currentIndex == getIndex(post: post) {
                                //updating offset
                                var offset = ((value > 0 ? -value : value) / width) * 80
                                offset = (-offset < 80 ? offset : -80)
                                post.logoOffset = offset
                            }
                            
                            //updating image when user cycles through projects
                            if value == 0 && currentIndex != getIndex(post: post) {
                                post.logoOffset = 0
                                
                                withAnimation(.easeInOut(duration: 0.6)) {
                                    //projects[currentIndex].showLogo = false
                                    currentIndex = getIndex(post: post)
                                    currentPost = projects[currentIndex]
                                }
                                
                               /* withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1).delay(0.4)) {
                                    projects[currentIndex].showLogo = true
                                } */

                            }
                        }
                }
            }
            .padding(.horizontal, -15)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .zIndex(0)
            
        }
        .padding(15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("unicorn"), ignoresSafeAreaEdges: .all)
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1).delay(0.4)) {
                projects[currentIndex].showLogo = true
            }
        }
    }
    
    var standView: some View {
        Rectangle()
            .fill(.black.opacity(0.6))
            .shadow(color: .white.opacity(0.85), radius: 20, x: 0, y: 5)
            .frame(height: 10)
            .overlay(alignment: .top) {
                Rectangle()
                    .fill(LinearGradient(colors: [.black.opacity(0.75), .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 385)
                    .rotation3DEffect(.init(degrees: -98), axis: (x: 1, y: 0, z: 0), anchor: .top, anchorZ: 0.5, perspective: 1)
                    .shadow(color: .black.opacity(0.08), radius: 25, x: 0, y: 5)
                    .shadow(color: .black.opacity(0.08), radius: 25, x: 0, y: 15)
            }
            .scaleEffect(1.5)
    }
    
    func getIndex(post: Post) -> Int {
        return projects.firstIndex { project in
            return project.id == post.id
        } ?? 0
    }
    
    @ViewBuilder
    func ProjectCardView(post: Post) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text("D.E.M.T.")
                    .fontWeight(.light)
                    .foregroundColor(.gray.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "leaf.circle.fill")
                    .font(.callout)
                    .foregroundColor(.topBG)
            }
            
            Text(post.postName ?? "")
                .font(.title)
                .bold()
            
            ScrollView {
                Text(post.postText ?? "")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
        }
        .padding(.top, 30)
        .padding([.horizontal, .bottom])
        .background {
            RoundedCorner(radius: 25, corners: [.bottomLeft, .bottomRight])
                .fill(.black.opacity(0.6))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.horizontal, 5)
        
    }
    
    @ViewBuilder
    func customScroller() -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            LazyHStack(spacing: 0) {
                ForEach($posts) { $post in
                    HStack(spacing: 0) {
                        Image(post.imageURL)
                            .resizedToFill(width: 180, height: 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 10)
                            .zIndex(1)
                        
                        /* //needs fine tuning
                         Image("demtLogo")
                            .resizedToFit(width: 160, height: 180)
                            .rotationEffect(.init(degrees: post.showLogo ? 0 : 40))
                            .rotationEffect(.init(degrees: post.logoOffset / -80) * 40)
                            .offset(x: post.showLogo ? post.logoOffset : 0)
                            .scaleEffect(post.showLogo ? 1 : 0.1)
                            .offset(x: post.showLogo ? 80 : 0)
                            .zIndex(0)
                         */
                    }
                    // 80 / 2 = 40
                    .offset(x: -35)
                    .frame(width: size.width, alignment: currentIndex > getIndex(post: post) ? .trailing : currentIndex == getIndex(post: post) ? .center : .leading)
                    .scaleEffect(currentPost.id == post.id ? 1 : 0.8, anchor: .bottom)
                    .offset(x: currentIndex > getIndex(post: post) ? 100 : currentIndex == getIndex(post: post) ? 0 : -40)
                }
            }
            .offset(x: CGFloat(currentIndex) * -size.width)
        }
        .frame(height: 180)
    }
    
    //MARK: Attributed String
    var titleString: AttributedString {
        var attString = AttributedString(stringLiteral: "Organizational Profile - D.E.M.T. : Protocol Number: MA0000072/2020")
        if let range = attString.range(of: "Organizational Profile") {
            attString[range].font = .largeTitle.bold()
        }
        
        return attString
    }
}

struct AboutUs_Previews: PreviewProvider {
    static var previews: some View {
        AboutUs()
            .preferredColorScheme(.dark)
    }
}


//Custom extension to find horizontal offset
extension View {
    func offsetX(completion: @escaping (CGFloat, CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader{ geometry in
                    Color.clear
                        .preference(key: OffsetXKey.self, value: geometry.frame(in: .global).minX)
                        .onPreferenceChange(OffsetXKey.self) { value in
                            completion(value, geometry.size.width)
                        }
                }
            }
    }
}

struct OffsetXKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
