//
//  AddRoomView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/24/22.
//

//
//  AddRoomView.swift
//  Forums
//
//  Created by Simbarashe Dombodzvuku on 2/8/22.
//

import SwiftUI

struct AddRoomView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var addRoomVM = AddRoomViewModel()
    @State private var showAlert: Bool = false
   
    var body: some View {
        VStack {
            
            Form {
                TextField("Enter name", text: $addRoomVM.name)
                TextField("Enter description", text: $addRoomVM.description)
                
            }
            
            Button("Save") {
                addRoomVM.createRoom {
                    //when the room is created, this view is dismissed because presentation mode is a binding to the current view in which it appears
                    presentationMode.wrappedValue.dismiss()
                }
                showAlert = true
            }
            //.buttonStyle(PrimaryButtonStyle())
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("✔️"), message: Text("Chat room created successfully!"), dismissButton: .default(Text("Continue")))
            }
            
            Spacer()
            
        }
        //.navigationTitle("Add New Room")
    }
}

struct AddRoomView_Previews: PreviewProvider {
    static var previews: some View {
        AddRoomView()
    }
}

