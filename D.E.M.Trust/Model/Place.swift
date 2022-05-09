//
//  Place.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/8/22.
//

import Foundation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

