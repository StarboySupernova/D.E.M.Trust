//
//  iPadLaunchPoint.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/21/22.
//

import SwiftUI

struct iPadLaunchPoint: View {
    var body: some View {
        TabView {
            //OnboardViews here. Navigation Path into main view to be built
            ForEach(intros){ intro in
                OnboardView(imageName: intro.image, title: intro.title, description: intro.description)
                    .foregroundStyle(intro.color)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
    }
}

struct iPadLaunchPoint_Previews: PreviewProvider {
    static var previews: some View {
        iPadLaunchPoint()
            .preferredColorScheme(.dark)
    }
}

struct OnboardView: View{
    let imageName: String
    let title: String
    let description: String
    var body: some View {
        VStack (spacing: 20) { 
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.teal)
            
            Text(title)
                .font(.title)
                .bold()
            
            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 40)
    }
}
