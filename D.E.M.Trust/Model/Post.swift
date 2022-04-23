//
//  Post.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/22/22.
//

import Foundation
import SwiftUI

struct Post: Identifiable, Hashable {
    var id = UUID().uuidString
    var imageURL: String
}

