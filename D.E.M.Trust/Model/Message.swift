//
//  Message.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/16/22.
//

import Foundation

struct Message: Identifiable, Codable {
    var id = UUID().uuidString
    var text: String
    var receiver: Bool
    var timestamp: Date //use date formatter in home
}
