//
//  WelcomeView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/23/22.
//

import SwiftUI

struct GalleryView: View {
    @State private var posts: [Post] = []
    @State private var columns: Int = 2
    //smooth hero effect
    @Namespace var animation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                Text("D.E.M.T. Gallery")
                    .font(.title)
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .modifier(ConcaveGlassView())
                
                Spacer()
                
                Button {
                    columns += 1
                    if columns > 4 {
                        columns = 1
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            
            StaggeredGrid(columns: columns, list: posts) { post in
                //Post card view
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
            }
            .padding(.horizontal)
            .animation(.easeInOut, value: columns)
        }
        .frame(maxHeight: .infinity)
        .frame(width: getRect().width)
        .background(
            Background()
                .cornerRadius(15)
                .padding(.top)
        )
        .onAppear {
            for index in 1...15 {
                posts.append(Post(imageURL: "post\(index)"))
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
            .preferredColorScheme(.dark)
    }
}

struct PostCardView: View {
    var post: Post
    
    var body: some View {
        Image(post.imageURL)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
    }
}
