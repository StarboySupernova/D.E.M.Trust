//
//  ContactList.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/25/22.
//

import SwiftUI

struct ContactList: View {
    @Binding var showContact: Bool
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(contacts) { contact in
                        HStack {
                            Image(contact.image)
                                .resizedToFit(width: 60, height: 60)
                                .clipShape(Ellipse())
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            Text(contact.name)
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal)
                        }
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.ultraThinMaterial)
                        }
                        .onTapGesture {
                            showContact = false
                        }
                        
                        Divider()
                    }
                }
            }
            .frame(maxWidth: getRect().width * 0.75, maxHeight: getRect().height * 0.7)
            .cornerRadius(10)
            
            Button {
                showContact = false
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background {
                        Circle()
                            .fill(Color("unicorn"))
                    }
            }
            .frame(width: 50, height: 50)

        }
    }
}

struct ContactList_Previews: PreviewProvider {
    static var previews: some View {
        ContactList(showContact: .constant(true))
            .preferredColorScheme(.dark)
    }
}

struct Contact: Identifiable {
    var id = UUID().uuidString
    var name: String
    var image: String
}

var contacts: [Contact] = [
    Contact(name: "Simba", image: "profile"),
    Contact(name: "Romeo", image: "romeo")
]
