//
//  OperationCard.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/4/22.
//

import SwiftUI

struct OperationCard: Identifiable, Equatable {
    var id = UUID().uuidString
    var name: String
    var locationNumber: String
    var cardImage: String
    var color: Color
}

var operationCards = [
    OperationCard(name: "Areas We Cover", locationNumber: "31° 3' E, 17° 49' S", cardImage: "explore", color: Color.cyan),
    OperationCard(name: "Gallery", locationNumber: "17.397° S, 32.2268° E", cardImage: "gardening", color: Color.brown),
    OperationCard(name: "Documentaries", locationNumber: "6ddb8b4ab4c15a09d14e", cardImage: "reading", color: Color.yellow),
]
