//
//  Card.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/28/22.
//

import Foundation

struct Card: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var category: String
    var description: String
    var province: String
}
