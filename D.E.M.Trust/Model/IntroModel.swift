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
    Intro(image: "naturephone3", title: "Welcome to D.E.M.T.", description: "A local non-governmental development actor", color: .topBG), //title and desc will come from demt document
    Intro(image: "flowers", title: "Non-profit", description: "providing relief and promoting recovery of disaster affected & vulnerable groups", color: .brown),
    Intro(image: "launch", title: "Community-led", description: "empowering grassroots communities through development projects & partnering with others", color: .yellow),
    Intro(image: "nature", title: "Environment-Conscious", description: "learn how to conserve your environment today", color: .teal),
    Intro(image: "demtLogo", title: "Disaster and Environmental Management Trust", description: "", color: .green),
    Intro(image: "demtLogo", title: "Disaster and Environmental Management Trust", description: "", color: .green),
]
