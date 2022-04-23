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
        NavigationView {
            StaggeredGrid(columns: columns, list: posts) { post in
                //Post card view
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
                    .onAppear {
                        
                    }
            }
            .padding(.horizontal)
            .navigationTitle("D.E.M.T Gallery")
            .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns += 1
                            if columns > 4 {
                                columns = 1
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                        } label: {
                            Text("Continue")
                        }
                    }
            }
            .animation(.easeInOut, value: columns)
        }
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
