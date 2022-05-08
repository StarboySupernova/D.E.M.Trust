//
//  TrainingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/1/22.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    let gradient = Gradient(stops: [Gradient.Stop(color: .white, location: 0.1), Gradient.Stop(color: .bottomBG, location: 0.8)])
    var body: some View {
        ZStack {
            Image("liquid-cheese")
                .resizable()
                .overlay {
                    Color.black.opacity(0.7)
                }
            VStack {
                ScrollView(horizontalSizeClass == .compact ? .horizontal : .init()) {
                    HStack {
                        tile(title: "Learn to take care of your environment", "welcomingtree")
                            /*.onHover { <#Bool#> in
                                <#code#>
                            }*/
                        tile(title: "Engaging with the grassroots community")
                        tile(title: "Discovering disaster prevention", "throughpark")
                        tile(title: "Leveraging modern technologies", "signalsearching")
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15, style: .circular)
                            .fill(Color.bottomBG)
                            .padding()
                            .padding(.bottom, 20)
                    )
                }
                Spacer()
            }
            
        }

    }
    
    @ViewBuilder
    func tile(title: String, _ imageName: String = "people") -> some View {
        ZStack (alignment: .top) {
            Color.bottomBG
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 200)
                .cornerRadius(35, corners: [.bottomRight])
            VStack(spacing: 20) {
                Spacer()
                Text(title + "\n")
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(-90), endAngle: .degrees(0)))
                            /*
                             //might be useful
                             .fill(LinearGradient(gradient: Gradient(stops: [
                                Gradient.Stop(color: .bottomBG, location: 0.1),
                                Gradient.Stop(color: .white, location: 0.2),
                                Gradient.Stop(color: .white, location: 0.9)
                            ]), startPoint: .topTrailing, endPoint: .bottomLeading))
                             */
                            .padding(.vertical, -15)
                    )
            }
        }
        .frame(width: 150, height: 275)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)

    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}
