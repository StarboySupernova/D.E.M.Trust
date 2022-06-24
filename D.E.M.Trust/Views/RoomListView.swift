//
//  RoomListView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 6/24/22.
//

//
//  RoomListView.swift
//  Forums
//
//  Created by Simbarashe Dombodzvuku on 2/8/22.
//

import SwiftUI

struct RoomListView: View {
    
    @State private var isPresented: Bool = false
    @StateObject private var roomListVM = RoomListViewModel()
    @State private var showRoom: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    
                    Button {
                        isPresented = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.title)
                            .foregroundColor(.green)
                    }
                }
                .modifier(FlatGlassView())
                
                List(roomListVM.rooms, id: \.roomId){ room in
                    RoomCell(room: room)
                        .onTapGesture {
                            showRoom = true
                        }
                        .sheet(isPresented: $showRoom, onDismiss: {
                            
                        }, content: {
                            ConversationView()
                        })
                    
                }
                //.navigationTitle("Rooms")
                .sheet(isPresented: $isPresented, onDismiss: {
                    
                }, content: {
                    AddRoomView()
                })
                .onAppear(perform: {
                    roomListVM.getAllRooms()
                })
            }
        }
    }
    
    struct RoomListView_Previews: PreviewProvider {
        static var previews: some View {
            RoomListView()
                .preferredColorScheme(.dark)
        }
    }
    
    struct RoomCell: View {
        let room: RoomViewModel
        
        var body: some View{
            VStack(alignment: .leading, spacing: 10){
                Text(room.name)
                    .font(.headline)
                Text(room.description)
            }

        }
    }
}
