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
    var imageURL: String //image name - "post\(index)"
    var postName: String? = nil
    var showLogo: Bool = false
    var logoOffset: CGFloat = 0
}

var projects: [Post] = []

