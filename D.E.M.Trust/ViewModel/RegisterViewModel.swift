//
//  RegisterViewModel.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/23/22.
//

//
//  RegisterViewModel.swift
//  Forums
//
//  Created by Simbarashe Dombodzvuku on 2/12/22.
//

import Foundation
import Firebase
import FirebaseAuth

class RegisterViewModel: ObservableObject {
    var email: String = ""
    var password: String = ""
    var username: String = ""
    
    func register(completion: @escaping () -> Void){
        Auth.auth().createUser(withEmail: email, password: password){ (result, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                completion()
            }
        }
    }
}
