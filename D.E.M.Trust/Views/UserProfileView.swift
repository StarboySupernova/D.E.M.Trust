//
//  UserProfileView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/20/22.
//

import SwiftUI

struct UserProfileView: View {
    @State private var isShowingPhotoPicker: Bool = false
    @State private var avatar = UIImage(named: "romeo")! //will need to upload this to firestore
    @State private var showUserAlert: Bool = false
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var registerVM = RegisterViewModel()
    
    @Binding var showUserProfile: Bool
    @Binding var userName: String
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var passwordAgain: String = ""
    
    @State private var animateGradient: Bool =  false
    
    var body: some View {
        //settings page feel
        VStack(spacing: 0) {
            HStack {
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, safeArea().top)
            .padding(.bottom, 80)
            .background(Color("unicorn"))
            .opacity(0.5)
            .clipShape(Corners(corner: [.bottomRight], size: CGSize(width: 55, height: 55)))
            
            HStack{
                VStack{
                    HStack{
                        Spacer()
                        
                        Image("demtLogo")
                            .resizable()
                            .saturation(0)
                        //.colorMultiply(Color("theme"))
                            .clipShape(Ellipse())
                            .frame(width: 170, height: 130)
                            .glow(color: .green, radius: 2)
                    }
                    .padding(.bottom, -35)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 15){
                            Text("D.E.M.T")
                                .font(.title)
                                .foregroundColor(.white)
                            
                            Text("Disaster Environmental \nManagement Trust")
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                        }
                        .foregroundColor(.white)
                        
                        Spacer()
                    }
                    .padding(.leading, 30)
                }
                .padding(.bottom, 35)
                .frame(width:getRect().width - 100)
                .background(Color("unicorn"))
                .clipShape(Corners(corner: [.topLeft, .topRight, .bottomRight], size: CGSize(width: 70, height: 70)))
                
                Spacer()
            }
            .padding(.top, -70)
            
            //account details header from richbackgroundview to be wrapped around this
            
            ZStack {
                Color("unicorn")
                
                ScrollView {
                    HStack{
                        Label {
                            Image(systemName: "leaf.fill")
                                .font(.footnote)
                                .foregroundColor(.green)
                        } icon: {
                            Image(systemName: "leaf.fill")
                                .font(.footnote)
                                .foregroundColor(.green)
                        }

                        Spacer()
                        
                        Text("Account Details".uppercased())
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .shadow(color: .black, radius: 5, x: 1, y: 1)
                    }
                    .padding()

                    
                    HStack {
                        Button {
                            //switch functionality, from History subcreen(to be created) to SignUp
                        } label: {
                            Label {
                                Text("Sign Up")
                                    .font(.body)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                            } icon: {
                                Image(systemName: "personalhotspot.circle")
                                    .font(.body)
                                    .foregroundColor(.topBG)
                            }
                        }
                        
                        Divider()
                        
                        Spacer()
                        
                        /*
                         Button {
                         //Fetching History of completed exercises from Firebase
                         } label: {
                         Label {
                         Image(systemName: "clock.arrow.circlepath")
                         .font(.body)
                         .foregroundColor(.topBG)
                         } icon: {
                         Text("History")
                         .font(.body)
                         .fontWeight(.heavy)
                         .foregroundColor(.white)
                         }
                         
                         }
                         */
                    }
                    .modifier(FlatGlassView())
                    .padding()
                    
                    VStack(spacing: 12) {
                        Image(uiImage: avatar)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .background(
                                Color("unicorn")
                                    .cornerRadius(15, corners: [.topLeft, .bottomRight])
                                    .glow(color: .green, radius: 3)
                            )
                            .padding()
                            .onTapGesture {
                                isShowingPhotoPicker = true
                            }
                        
                        Text("Set Profile Picture".uppercased())
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .shadow(color: .black, radius: 5, x: 1, y: 1)
                        
                        TextField("Enter username", text: showUserAlert ? $userName : $registerVM.username)
                            .autocapitalization(.none)
                            .modifier(ConcaveGlassView())
                            .frame(width: getRect().width * 0.75)
                        
                        TextField("Enter email", text: $registerVM.email)
                            .autocapitalization(.none)
                            .modifier(ConcaveGlassView())
                            .frame(width: getRect().width * 0.75)
                        
                        SecureField("Enter password", text: $registerVM.password)
                            .autocapitalization(.none)
                            .modifier(ConcaveGlassView())
                            .frame(width: getRect().width * 0.75)
                        
                        
                        SecureField("Re-enter password", text: $registerVM.password)
                            .autocapitalization(.none)
                            .modifier(ConcaveGlassView())
                            .frame(width: getRect().width * 0.75)
                        
                        Divider().padding()
                        
                        Text("By signing up you accept the **Terms of Service** and **Privacy Policy**")
                            .font(.footnote)
                        
                        Button {
                            //TODO:- add action
                            showUserAlert = true
                            registerVM.register {
                                dismiss()
                            }
                        } label: {
                            ZStack {
                                Text("SIGN UP")
                                    .bold()
                                    .foregroundColor(.white)
                                    .frame(maxWidth: getRect().width * 0.85)
                                //.frame(height:  getRect().height * 0.075)
                                //.background(.thickMaterial)
                                .cornerRadius(14)
                                    .modifier(ConvexGlassView())
                                    .padding(.bottom, 8)
                            }
                        }
                        .alert(isPresented: $showUserAlert) {
                            Alert(title: Text("✔️"), message: Text("User registered successfully"), dismissButton: .default(Text("Continue")))
                        }
                    }
                    .padding()
                    .background {
                        /*ZStack {
                            LinearGradient(colors: [Color("unicorn"), .bottomBG], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .hueRotation(.degrees(animateGradient ? 45 : 0))
                                .ignoresSafeArea()
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                                        animateGradient.toggle()
                                    }
                                }
                            
                            Rectangle()
                                .fill(.thinMaterial)
                        }*/
                    }
                    .foregroundColor(Color.primary.opacity(0.35))
                    .foregroundStyle(.ultraThinMaterial)
                    .cornerRadius(15, corners: [.topRight, .bottomRight, .bottomLeft])
                }
                .clipShape(Corners(corner: [.topLeft], size: CGSize(width: 70, height: 70)))
            }
            
            Spacer()
        }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(avatar: $avatar)
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(showUserProfile: .constant(true), userName: .constant("username"))
            .preferredColorScheme(.dark)
    }
}
