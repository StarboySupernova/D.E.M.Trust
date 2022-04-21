//
//  LiquidSwipe.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/20/22.
//

import Foundation
import SwiftUI

struct LiquidSwipe: Shape {
    @Binding var showHome: Bool //makes this useful in this file only
    //getting offset size
    var offset: CGSize
    //animating path
    var animatableData: CGSize.AnimatableData {
        get {
            return offset.animatableData
        }
        set {
            offset.animatableData = newValue
        }
    }
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width + (-offset.width > 0 ? offset.width : 0)
            //first, constructing a rectangle shape
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            //constructing curve shape
            //from
            let from = 5 + (offset.width) //for liquid effect
            path.move(to: CGPoint(x: rect.width, y: from > 80 ? 80 : from))
            //to
            var to = 5 + (offset.height) + (-offset.width) //also adding height
            to = to < 180 ? 180 : to
            
            let mid: CGFloat = 80 + ((to - 80) / 2)
            path.addCurve(to: CGPoint(x: rect.width, y: to), control1: CGPoint(x: width - 50, y: mid), control2: CGPoint(x: width - 50, y: mid))
        }
    }
}

