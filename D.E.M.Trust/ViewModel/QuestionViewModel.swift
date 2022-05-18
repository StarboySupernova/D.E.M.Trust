//
//  QuestionViewModel.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/18/22.
//

import Foundation
import Firebase

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    func getQuestions(set: String) {
        let db = Firestore.firestore()
        
        db.collection("Exam_1").getDocuments { snapshot, error in
            guard let data = snapshot else {
                return
            }
            
            DispatchQueue.main.async {
                self.questions = data.documents.compactMap({ (doc) -> Question? in  //used more explicit closure definition here for personal clarity
                    return try? doc.data(as: Question.self)
                })
                
            }
        }
    }
}
