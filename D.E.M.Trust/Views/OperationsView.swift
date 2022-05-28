//
//  OperationsView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/4/22.
//

import SwiftUI

struct OperationsView: View {
    //Animation properties
    @State private var expandCards: Bool = false
    
    //Detail view properties
    @State private var currentCard: OperationCard?
    @State private var showDetailCard: Bool = false
    @Namespace private var animation
    
    var body: some View {
        VStack (spacing: 0) {
            Text("Operations")
                .font(.largeTitle)
                .fontWeight(.ultraLight)
                .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
                .overlay (alignment: .trailing) {
                    Button {
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                            expandCards = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.customOrange ,in: Circle())
                    }
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack (spacing: 0) {
                    //MARK: Cards for the Operations View
                    ForEach(operationCards) {card in
                        Group {
                            if currentCard?.id == card.id && showDetailCard {
                                //to resolve matchedGeometry results undefined console warning
                            } else {
                                OperationCardView(card: card)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                currentCard = card
                                showDetailCard = true
                            }
                        }
                    }
                }
                .overlay{
                    //to avoid scolling
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                expandCards = true
                            }
                        }
                }
                .padding(.top, expandCards ? 30 : 0)
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity) //maybe problematic
        .overlay {
            if let currentCard = currentCard, showDetailCard {
                OperationsDetailView(currentCard: currentCard, showDetail: $showDetailCard, animation: animation)
            }
        }
    }
    
    @ViewBuilder
    func OperationCardView(card: OperationCard) -> some View {
        GeometryReader{ geometry in
            let rect = geometry.frame(in: .named("SCROLL"))
            //displaying a portion of each card
            let offset = CGFloat(getIndex(card: card) * (expandCards ? 10 : 70))
            ZStack(alignment: .bottomLeading) {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(expandCards ? LinearGradient(mycolors: card.color) : LinearGradient(mycolors: .topBG, card.color))
                
                Image(card.cardImage)
                    .resizable()
                    .frame(width: getRect().width * 0.9, height: 200)
                
                VStack(alignment: .leading, spacing: 10){
                    Text(card.name)
                        .fontWeight(.bold)
                    
                    Text(card.locationNumber)
                        .font(.callout)
                        .fontWeight(.ultraLight)
                }
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(.white)
                .background(
                    Background()
                        .opacity(0.3)
                        .cornerRadius(15, corners: [.topRight, .bottomLeft])
                )
            }
            //Making it a stack
            .offset(y: expandCards ? offset : -rect.minY + offset)
            
        }
        //max size
        .frame(height: 200)
        
    }
    //Retrieving Index
    func getIndex(card: OperationCard) -> Int {
        return operationCards.firstIndex { currentCard in
            return currentCard.id == card.id
        } ?? 0
    }
    
}

struct OperationsView_Previews: PreviewProvider {
    static var previews: some View {
        OperationsView()
            .preferredColorScheme(.dark)
    }
}

//MARK: Operation Detail View
struct OperationsDetailView :  View {
    var currentCard: OperationCard
    @Binding var showDetail: Bool
    //Matched Geometry effect
    var animation: Namespace.ID
    
    //delaying respective view
    @State private var showView : Bool = false
    
    var body: some View {
        VStack {
            CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 200)
                .overlay(alignment: .topTrailing, content: {
                    Button {
                        // closing respective view executed first, before detail
                        withAnimation(.easeInOut) {
                            showView = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showDetail = false
                            }
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(Color.customOrange ,in: Circle())
                    }
                    
                })
                .onTapGesture {}
                .zIndex(10)
            
            GeometryReader{ geometry in
                let height = geometry.size.height + 50
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MapView here
                    }
                    .padding()
                }
                .frame(maxWidth: getRect().width)
                .background(
                    ZStack {
                        Color.darkStart
                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                            .ignoresSafeArea()
                        
                        if currentCard == operationCards[0] {
                            MapView()
                        } else if currentCard == operationCards[1] {
                            /*@START_MENU_TOKEN@*/EmptyView()/*@END_MENU_TOKEN@*/ //this will come from WalletUI video
                        } else {
                            EmptyView()
                        }
                    }
                )
                .offset(y: showView ? 0 : height)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(mycolors: .topBG, .black)
                .ignoresSafeArea()
        )
        .onAppear {
            withAnimation(.easeInOut.delay(0.1)) {
                showView = true
            }
        }
    }
    
    @ViewBuilder
    func CardView() -> some View {
        ZStack(alignment: .bottomLeading) {
            Image(currentCard.cardImage)
                .resizable()
                .frame(width: getRect().width * 0.9, height: 200)
            
            VStack(alignment: .leading, spacing: 10){
                Text(currentCard.name)
                    .fontWeight(.bold)
                
                Text(currentCard.locationNumber)
                    .font(.callout)
                    .fontWeight(.ultraLight)
            }
            .padding()
            .padding(.bottom, 10)
            .foregroundColor(.white)
            .background(
                Background()
                    .opacity(0.3)
                    .cornerRadius(15, corners: [.topLeft, .bottomRight])
            )
        }
    }
}
