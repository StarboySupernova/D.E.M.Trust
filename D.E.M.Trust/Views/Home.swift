//
//  Home.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/24/22.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var modelData: ModelData
    @State var currentItem: Card?
    @State private var showDetailPage: Bool = false
    @State private var showArtistSheet: Bool = false
    
    //Matched Geometry Effect
    @Namespace var animation
    
    //Detail animation properties
    @State private var animateView: Bool = false
    @State private var animateContent: Bool = false
    @State private var scrollOffset: CGFloat = 0
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(todaysDate())
                            .font(.callout)
                            .foregroundColor(.orange)
                            .padding(.top, 30)
                        
                        Text("Today")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    /*
                     Button {
                        
                    } label: {
                        Image(systemName: "person.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.topBG)
                    }
                     */
                }
                .padding(.horizontal)
                .padding(.bottom)
                .opacity(showDetailPage ? 0 : 1)
                
                ForEach(modelData.projects) { item in
                    if showDetailPage == false {
                        Button {
                            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                                currentItem = item
                                showDetailPage = true
                            }
                        } label: {
                            CardView(item: item)
                            //applied scale effect and not padding for matched geometry
                            //Used approximate value to mimic the padding
                                .scaleEffect(currentItem?.id == item.id && showDetailPage ? 1 : 0.93)
                        }
                        .buttonStyle(ScaledButtonStyle())
                        .opacity(showDetailPage ? (currentItem?.id == item.id ? 1 : 0) : 1)
                    }
                }
            }
            .padding(.vertical)
        }
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .cornerRadius(55, corners: .topRight)
                .opacity(0.3)
        )
        .overlay {
            if let currentItem = currentItem, showDetailPage {
                DetailsView(item: currentItem)
                    .ignoresSafeArea(.container, edges: .top)
            }
        }
        .background(alignment: .top) {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(LinearGradient(mycolors: Color.darkEnd, Color.darkStart, Color.darkEnd))
                .frame(height: animateView ? nil : 350, alignment: .top)
                .opacity(animateView ? 1 : 0)
                .ignoresSafeArea()
        }
    }
    
    //CardView
    @ViewBuilder
    func CardView(item: Card) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            ZStack(alignment: .topTrailing) {
                //Banner Image
                GeometryReader{ geometry in
                    let size = geometry.size
                    
                    Image(item.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                }
                .frame(height: 400)
                
                LinearGradient(mycolors: .black.opacity(0.5), .black.opacity(0.2), .clear)
                
                VStack(alignment: .trailing, spacing: 8) {
                    Text(item.category.uppercased())
                        .font(.callout)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.trailing)
                    
                    Text(item.name)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.trailing)
                }
                .foregroundColor(.primary)
                .padding()
                .offset(y: currentItem?.id == item.id && animateView ? safeArea().top : 0)
            }
            
            HStack(spacing: 12) {
                Image("demtLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.province.uppercased())
                        .font(.caption)
                        .foregroundColor(.black)
                    
                    Text(item.category)
                        .fontWeight(.bold)
                    
                    Text(item.description)
                        .truncationMode(.tail)
                        .font(.caption)
                        .foregroundColor(.black)
                        .frame(height: 40)
                }
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button {
                    //preliminary idea - go to videoplayer
                } label: {
                    Text("More")
                        .fontWeight(.bold)
                        .foregroundColor(.customOrange)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 20)
                        .background {
                            Capsule()
                                .fill(.ultraThinMaterial)
                        }
                }
                
            }
            .padding([.horizontal, .bottom])
        }
        .background {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.topBG)
        }
        .matchedGeometryEffect(id: item.id, in: animation)
    }
    
    //Details View
    @ViewBuilder
    func DetailsView(item: Card) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                CardView(item: item)
                    .scaleEffect(animateView ? 1 : 0.93)
                
                VStack(spacing: 15) {
                    Text(item.description)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(10)
                        .padding(.bottom, 20)
                    
                    Divider()
                    
                    Button {
                        
                    } label: {
                        Label {
                            Text("More")
                                .foregroundColor(.black)
                        } icon: {
                            Image(systemName: "ellipsis")
                        }
                        .sheet(isPresented: $showArtistSheet, onDismiss: {
                            animateView = false
                            animateContent = false
                            showDetailPage = false
                            showArtistSheet = false
                        }, content: {
                            
                        })
                        .foregroundColor(.primary)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 25)
                        .background {
                            RoundedRectangle(cornerRadius: 5, style: .continuous)
                                .fill(Color.bottomBG)
                        }
                    }
                    
                }
                .padding()
                .offset(y: scrollOffset > 0 ? scrollOffset : 0)
                .opacity(animateContent ? 1 : 0)
                .scaleEffect(animateView ? 1 : 0 , anchor: .top)
            }
            .offset(y: scrollOffset > 0 ? -scrollOffset : 0)
            .offset(offset: $scrollOffset)
        }
        .overlay(alignment: .topTrailing, content: {
            Button {
                //Closing View
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                    animateView = false
                    animateContent = false
                }
                
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.05)) {
                    currentItem = nil
                    showDetailPage  = false
                }
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.orange)
            }
            .padding()
            .padding(.top, safeArea().top)
            .offset(y: -10)
            .opacity(animateView ? 1 : 0)
        })
        .onAppear {
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                animateView = true
            }
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.1)) {
                animateContent = true
            }
            
        }
        .transition(.identity)
    }
    
    func todaysDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: Date())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .preferredColorScheme(.dark)
            .environmentObject(ModelData())
    }
}

//Scaled ButtonStyle
struct ScaledButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}




