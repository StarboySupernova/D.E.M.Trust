//
//  OffsetPageTabView.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 5/15/22.
//

import SwiftUI

//custom view that will return offset for paging control
struct OffsetPageTabView<Content: View>: UIViewRepresentable {

    var content: Content
    @Binding var offset: CGFloat
    
    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.content = content()
    }
    

    func makeUIView(context: Context) -> UIScrollView {

        let scrollView = UIScrollView()

        //Extracting SwiftUI View and embedding it into UIKit ScrollView
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //if you are using vertical paging in future, do not declare height constraint
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor),

        ]
        
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(constraints)
        
        return scrollView
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
}

struct OffsetPageTabView_Previews: PreviewProvider {
    static var previews: some View {
        WalkThroughView()
    }
}

