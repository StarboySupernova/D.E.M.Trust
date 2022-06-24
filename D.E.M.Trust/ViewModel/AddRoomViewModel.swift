//
//  AddRoomViewModel.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/24/22.
//

//
//  AddRoomViewModel.swift
//  Forums
//
//  Created by Simbarashe Dombodzvuku on 2/8/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddRoomViewModel: ObservableObject {
    
    var name: String = ""
    var description: String = ""
    let db = Firestore.firestore()
    
    func createRoom(completion: @escaping () -> Void) {
        
        let room = Room(name: name, description: description)
        
        do {
            
            _ = try db.collection("rooms")
                .addDocument(from: room, encoder: Firestore.Encoder()) { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        completion()
                    }
                }
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
}

extension Encodable {
    /// Convenience function for object which adheres to Codable to compile the JSON
    func compile () -> [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else {
            print("Couldn't encode the given object")
            preconditionFailure("Couldn't encode the given object")
        }
        return (try? JSONSerialization
            .jsonObject(with: data, options: .allowFragments))
            .flatMap { $0 as? [String: Any] }!
    }
}
