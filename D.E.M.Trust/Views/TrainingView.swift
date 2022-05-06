//
//  TrainingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/1/22.
//

import SwiftUI

struct TrainingView: View {
    var body: some View {
        ZStack {
            
            ZStack (alignment: .top) {
                Background()
                Image("demtGenderAgriculture")
                    .resizedToFillAspectRatio(width: 150, height: 200, aspectRatio: 9/16)
                    .clipped()
                    .cornerRadius(25, corners: [.bottomRight, .topLeft, .topRight])
                VStack(spacing: 20) {
                    Spacer()
                    Text("Learn to take care of your environment")
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                                .padding(.vertical, -15)
                        )
                }
                .frame(width: 150, height: 275)
            }
        }
        .frame(width: 150, height: 300)
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
