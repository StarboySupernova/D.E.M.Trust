//
//  MapView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/7/22.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -17.410421017982685, longitude: 32.24006652178922), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
    let annotations = [
        Place(name: "D.E.M.T. HQ", coordinate: CLLocationCoordinate2D(latitude: -17.410421017982685, longitude: 32.24006652178922)),
    ]
    
    var body: some View {
        /* NavigationView {
         ZStack {
         GeometryReader { geometry in
         Map(coordinate: CLLocationCoordinate2D(latitude: -17.39699, longitude: 32.22677))
         .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
         }
         }
         .navigationTitle("D.E.M.T. Headquarters")
         } */
        Map(coordinateRegion: $region, annotationItems: annotations, annotationContent: { place in
            MapAnnotation(coordinate: place.coordinate) {
                VStack(spacing: 2) {
                    Image("demtTeam")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10, corners: [.topRight, .bottomLeft])
                        .frame(width: 150, height: 150, alignment: .center)
                    
                    LabelledDivider(label: "", horizontalPadding: 2, color: .black)
                    
                    HStack {
                        Text(place.name)
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .kerning(2)
                            .multilineTextAlignment(.leading)
                        
                        Button {
                            //cubic transition
                        } label: {
                            Text("Next")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .padding(10)
                                .background(.green, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                        }
                    }
                }
                .frame(width: 300, height: 200, alignment: .center)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.ultraThinMaterial)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .foregroundColor(.green)
                        .offset(y: 15)
                }
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .preferredColorScheme(.dark)
    }
}
//-17.39699,
// 32.22677

/*
 -17.410421017982685, 32.24006652178922
 */
