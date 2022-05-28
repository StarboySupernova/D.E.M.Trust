//
//  TrainingView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/1/22.
//

import SwiftUI

struct TrainingView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    @State private var scrollToEnd: Bool = false
    //@State private var progress: CGFloat = 0  //for animatablegradient, which will not be implemented here but in introduction
    @State private var animateGradient: Bool = false
    @Namespace private var animation
    @State private var show: Bool = false
    
    let gradient = Gradient(stops: [Gradient.Stop(color: .white, location: 0.1), Gradient.Stop(color: Color.green, location: 0.8)])
    
    /*
     let backgroundGradient = Gradient(colors: [.darkStart, .bottomBG])
     let backgroundGradient2 = Gradient(colors: [.darkEnd, .topBG])
     */
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.darkStart, .black, .darkEnd], startPoint: .topLeading, endPoint: .bottomTrailing)
                .hueRotation(.degrees(animateGradient ? 45 : 0))
                .ignoresSafeArea()
                .onAppear {
                    withAnimation(.easeInOut(duration: 5.0).repeatForever(autoreverses: true)) {
                        animateGradient.toggle()
                    }
                }
            
            if show {
                QuestionDetailView(animation: animation, show: $show)
            }

            if !show {
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
                    
                    ZStack {
                        Color("unicorn")
                        
                        GeometryReader { geometry in
                            ScrollView(.vertical, showsIndicators: false){
                                VStack(spacing: -20) {
                                        HStack{
                                            Text("Explore Categories".uppercased())
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal)
                                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                            Spacer()
                                            
                                            Label {
                                                Image(systemName: "leaf.fill")
                                                    .font(.footnote)
                                                    .foregroundColor(.green)
                                            } icon: {
                                                Image(systemName: "leaf.fill")
                                                    .font(.footnote)
                                                    .foregroundColor(.green)
                                            }

                                        }
                                        .foregroundColor(.white)
                                        .padding(.leading, 35)
                                        .padding(.top, 50)
                                    .padding(.trailing)

                                    
                                    
                                        ScrollViewReader { scrollView in
                                            ScrollView(horizontalSizeClass == .compact ? .horizontal : .init(), showsIndicators: false) {
                                                Button {
                                                    if scrollToEnd == false {
                                                        withAnimation(.spring()) {
                                                            scrollView.scrollTo(3)
                                                            //will not work since container view is a scrollview, hence according to the documentation, the view is wholly visible inside the container if the container is a scrollview or any other view that has no fixed anchor
                                                            //needed to remove containing horizontal scrollview for this to work
                                                            //will still remove anyway for both sylistic reasons and to suppress compiler warning - 2022-05-28 01:12:56.328272+0100 D.E.M.Trust[68625:696460] [error] precondition failure: invalid graph update (access from multiple threads?)
                                                        }
                                                        
                                                        scrollToEnd = true
                                                    }
                                                } label: {
                                                    Image(systemName: "chevron.right")
                                                        .font(.title3)
                                                        .foregroundColor(.white)
                                                        //.resizedToFit(width: 35, height: 30)
                                                        .padding(10)
                                                        .background(
                                                            Ellipse()
                                                                .stroke(.white, style: StrokeStyle())
                                                                .background(Ellipse().fill(.green))
                                                        )
                                                }
                                                .opacity(scrollToEnd ? 0 : 1)
                                                .frame(width: 60, height: 60)
                                                .offset(x: getRect().width < 400 ? -25 : 5)
                                                
                                                HStack {
                                                    //can make array of tiles in future, for better modularity
                                                    tile(title: "Learn to take care of your environment", "welcomingtree")
                                                        .id(0)
                                                    tile(title: "Engage with the grassroots community")
                                                        .id(1)
                                                    tile(title: "Discover disaster prevention and mitigation", "throughpark")
                                                        .id(2)
                                                    tile(title: "Leverage modern technologies", "signalsearching")
                                                        .id(3)
                                                }
                                                .padding()
                                                .background(
                                                    RoundedRectangle(cornerRadius: 15, style: .circular)
                                                        .fill(Color.topBG)
                                                        .padding()
                                                        .padding(.bottom, 20)
                                                )
                                            }
                                        }
                                    .padding(.top, 25)
                                    
                                    HStack{
                                        Text("Community Learnerships".uppercased())
                                            .font(.footnote)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding(.horizontal)
                                            .shadow(color: .black, radius: 5, x: 1, y: 1)
                                        Spacer()
                                        
                                        Label {
                                            Image(systemName: "leaf.fill")
                                                .font(.footnote)
                                                .foregroundColor(.green)
                                        } icon: {
                                            Image(systemName: "leaf.fill")
                                                .font(.footnote)
                                                .foregroundColor(.green)
                                        }

                                    }
                                    .foregroundColor(.white)
                                    .padding(.leading, 25)
                                    .padding(.top, 25)
                                    .padding(.trailing)
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 25) {
                                            Text("Courses".uppercased())
                                                .font(.footnote)
                                                .fontWeight(.semibold)
                                                .foregroundColor(.white)
                                                .padding(.horizontal)
                                                .shadow(color: .black, radius: 5, x: 1, y: 1)
                                            
                                            QuestionComponent(animation: animation, show: $show)
                                                .onTapGesture {
                                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                                        show.toggle()
                                                        //change set from inside here when we have multiple exams
                                                    }
                                                }

                                        }
                                        .padding(.horizontal, 25)
                                    }
                                    .padding(.top, 25)
                                    .padding(.bottom, safeArea().bottom + 5)
                                    }
                            }
                            .background(LinearGradient(mycolors: .darkEnd, Color("unicorn")))
                            .clipShape(Corners(corner: [.topLeft], size: CGSize(width: 70, height: 70)))

                        }

                    }
                    
                    Spacer()
                }
                .ignoresSafeArea(.all)
                .statusBar(hidden: true)
            }
        }
        
        /*
         .animatableGradient(fromGradient: backgroundGradient, toGradient: backgroundGradient2, progress: progress)
         .onAppear {
         withAnimation(.linear(duration: 5.0).repeatForever(autoreverses: true)) {
         self.progress = 1.0
         }
         }
         */
    }
    
    @ViewBuilder
    func tile(title: String, _ imageName: String = "people") -> some View {
        ZStack (alignment: .top) {
            Image(imageName)
                .resizable()
                .frame(width: 150, height: 200)
                .cornerRadius(35, corners: [.bottomRight])
            VStack(spacing: 20) {
                Spacer()
                Text(title + "\n")
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 5)
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(AngularGradient(gradient: gradient, center: .center, startAngle: .degrees(-90), endAngle: .degrees(0)))
                            .padding(.vertical, -15)
                    )
            }
        }
        .frame(width: 150, height: 275)
        .padding(.horizontal, 10)
        .padding(.vertical, 20)
        
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
            .preferredColorScheme(.dark)
    }
}
