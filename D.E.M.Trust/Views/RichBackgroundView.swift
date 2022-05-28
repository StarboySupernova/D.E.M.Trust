//
//  RichBackgroundView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/27/22.
//

import SwiftUI

struct RichBackgroundView: View {
    var body: some View {
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
                        
                        Image("moonship")
                            .resizable()
                            .frame(width: 170, height: 130)
                    }
                    .padding(.bottom, -35)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 15){
                            Text("D.E.M.T Training")
                                .font(.title)
                            
                            Text("Disaster Preparedness \nand \nEnvironmental Awareness")
                                .font(.headline)
                                .fontWeight(.bold)
                            
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
            
            ZStack{
                Color("unicorn")
                
                ScrollView(.vertical, showsIndicators: false){
                    HStack{
                        Text("Explore Categories")
                            .fontWeight(.bold)
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 35)
                    .padding(.top, 50)
                    .padding(.trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        ExampleCardView() //generic here
                    }
                    .padding(.top, 25)
                    
                    HStack{
                        Text("Popular Searches")
                            .fontWeight(.bold)
                            .font(.system(.body, design: .rounded))
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .font(.title)
                        }
                    }
                    .foregroundColor(.white)
                    .padding(.leading, 25)
                    .padding(.top, 25)
                    .padding(.trailing)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            VStack(spacing: 10){
                                HStack{
                                    Spacer()
                                    Image("flatmountainbackground")
                                        .resizable()
                                        .frame(width:100, height:70)
                                }
                                
                                HStack{
                                    VStack(alignment: .leading, spacing: 15){
                                        Text("UX/UI")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                        
                                        Text("Designer")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("15 Job Opportunities")
                                            .font(.title)
                                            .foregroundColor(.gray)
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading, 25)
                            }
                            .padding(.bottom, 20)
                            .frame(width:getRect().width / 2)
                            .background(Color.yellow)
                            .cornerRadius(35)
                            
                            VStack(spacing: 10){
                                HStack{
                                    Spacer()
                                    Image("flatmountainbackground")
                                        .resizable()
                                        .frame(width:100, height:70)
                                }
                                
                                HStack{
                                    VStack(alignment: .leading, spacing: 15){
                                        Text("iOS")
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                        
                                        Text("Developer")
                                            .font(.title)
                                            .foregroundColor(.black)
                                        
                                        Text("4 Job Opportunities")
                                            .font(.title)
                                            .foregroundColor(.gray)
                                        
                                    }
                                    
                                    Spacer()
                                }
                                .padding(.leading, 25)
                            }
                            .padding(.bottom, 20)
                            .frame(width:getRect().width / 2)
                            .background(Color.yellow)
                            .cornerRadius(35)
                        }
                        .padding(.horizontal, 25)
                    }
                    .padding(.top, 25)
                    .padding(.bottom, safeArea().bottom + 5)
                }
                .background(LinearGradient(mycolors: .darkEnd, Color("unicorn")))
                .clipShape(Corners(corner: [.topLeft], size: CGSize(width: 70, height: 70)))
                
            }
            
            Spacer()
        }
        .ignoresSafeArea(.all)
        .statusBar(hidden: true)
        
    }
}

struct ExampleCardView: View {
    var body: some View {
        HStack(spacing: 25){
            VStack(spacing: 12){
                Image(systemName: "desktopcomputer")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                
                Text("IT")
                    .foregroundColor(.black)
                    .padding(.horizontal, 5)
                    .padding(.vertical, 30)
                    .background(Color.brown)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 25)
    }
}

struct Corners: Shape {
    var corner: UIRectCorner
    var size: CGSize
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: size)
        return Path(path.cgPath)
    }
}

struct RichBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        RichBackgroundView()
            .preferredColorScheme(.dark)
    }
}


