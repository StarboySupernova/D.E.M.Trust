//
//  OnBoardingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/19/22.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
        // getting geometry globally as opposed to inside WalkThroughView
        
        GeometryReader { geometry in
            let size = geometry.size
            
            WalkThroughView(screenSize: size)
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
            .preferredColorScheme(.dark)
    }
}
