//
//  MapComponent.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/7/22.
//

import Foundation
import UIKit
import SwiftUI
import MapKit

struct UIMap: UIViewRepresentable {
    
    typealias UIViewType = UIView
    var coordinate = CLLocationCoordinate2D()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        let map = MKMapView()
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            map.widthAnchor.constraint(equalTo: view.widthAnchor),
            map.heightAnchor.constraint(equalTo: view.heightAnchor),
            map.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            map.centerYAnchor.constraint(equalTo: view.centerYAnchor),
         ])
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        map.addAnnotation(pin)
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}
