//
//  CourseModel.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/16/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable {
    @DocumentID var id: String? //will fetch document id
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var answer: String?
    var isSubmitted = false
    var completed = false
    
    //declaring the coding keys with respect to firebase firestore Key
    
    enum CodingKeys: String, CodingKey {
        case question
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case answer
    }
}
