//
//  OnBoardingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/19/22.
//

import SwiftUI

struct OnBoardingView: View {
    @Binding var showHome: Bool
    @Binding var showWalkthrough: Bool
    var body: some View {
        // getting geometry globally as opposed to inside WalkThroughView
        
        GeometryReader { geometry in
            let size = geometry.size
            
            WalkThroughView(showHome: $showHome, showWalkthrough: $showWalkthrough, screenSize: size)
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(showHome: .constant(false), showWalkthrough: .constant(true))
            .preferredColorScheme(.dark)
    }
}
