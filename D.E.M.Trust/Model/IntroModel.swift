//
//  IntroModel.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/15/22.
//

import Foundation
import SwiftUI

struct Intro: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var description: String
    var color: Color
}

var intros: [Intro] = [
    Intro(image: "naturephone3", title: "Welcome to D.E.M.T.", description: "hgdutdo", color: .topBG), //title and desc will come from demt document
    Intro(image: "flowers", title: "nvbsbh", description: "ncgygy", color: .brown),
    Intro(image: "launch", title: "kljghd", description: "kabvd", color: .yellow),
    Intro(image: "demtLogo", title: "dfgfjhg", description: "hdgfts", color: .teal)
]
