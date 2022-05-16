//
//  WalkthroughView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/15/22.
//

import SwiftUI

struct WalkThroughView: View {
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("D.E.M.T.")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Button {
                    //skip the walkthrough
                } label: {
                    Text("Skip")
                        .font(.caption)
                        .foregroundColor(.white)
                        .modifier(ConvexGlassView())
                }
                .frame(width: 50, height: 20)
                .padding()
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            
            OffsetPageTabView(offset: $offset) {
                GeometryReader{ geometry in
                    
                    let size = geometry.size
                    
                    HStack(spacing: 0){
                        ForEach(intros) {intro in
                            VStack {
                                Image(intro.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: size.height / 3)
                            }
                            .padding()
                        }
                    }
                    .frame(width: size.width)
                }
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity, alignment: .top)
    }
}

struct WalkThroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughView()
    }
}

