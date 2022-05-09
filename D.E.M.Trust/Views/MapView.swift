//
//  MapView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/7/22.
//

import SwiftUI
import MapKit


struct MapView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: -17.410297406604236, longitude:  32.225303461419905), latitudinalMeters: 1000, longitudinalMeters: 1000)
    
    let annotations = [
        Place(name: "D.E.M.T. HQ", coordinate: CLLocationCoordinate2D(latitude: -17.410297406604236, longitude:  32.225303461419905)),
        Place(name: "Mutoko RDC", coordinate: CLLocationCoordinate2D(latitude:  -17.405219593471937, longitude:  32.22156983863289)),
        Place(name: "Mutoko Hospital", coordinate: CLLocationCoordinate2D(latitude: -17.404646287223347, longitude: 32.23113996041184)),
        Place(name: "DAO", coordinate: CLLocationCoordinate2D(latitude: -17.405281019063636, longitude: 32.22427350534853))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations, annotationContent: { place in
            MapAnnotation(coordinate: place.coordinate) {
                Group {
                    if place.name == annotations.first?.name {
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
                    } else {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(.red)
                            
                            Text(place.name)
                                .font(.body)
                                .foregroundColor(.black)
                        }
                        .padding(10)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .circular))
                        .overlay(alignment: .bottom) {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.green)
                                .offset(y: 15)
                        }
                    }
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
/*
 -17.405219593471937,
 32.22156983863289
 */

/*
 1st demt values
 -17.410421017982685, 32.24006652178922
 
 -17.410297406604236,
 32.225303461419905
 */
