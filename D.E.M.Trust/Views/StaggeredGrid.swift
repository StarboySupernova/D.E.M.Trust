//
//  StaggeredGrid.swift
//  D.E.M.Trust
//
//  Created by Simbarashe Dombodzvuku on 4/22/22.
//

import SwiftUI

//Custom view builder
// T is to hold the identifiable collection of data
struct StaggeredGrid<Content: View, T: Identifiable>: View where T: Hashable {
    
    //will return each item in the collection to build view
    var content : (T) -> Content
    var list : [T]
    
    //columns
    var columns: Int
    
    //properties
    var showIndicators: Bool = false
    var spacing: CGFloat
    
    init(columns: Int, showIndicators: Bool = false, spacing: CGFloat = 10, list: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.content = content
        self.list = list
        self.showIndicators = showIndicators
        self.spacing = spacing
        self.columns = columns
    }
    
    //Staggered Grid function
    func setUpList() -> [[T]] {
        //creating empty subarrays of columns count
        var gridArray: [[T]] = Array(repeating: [], count: columns)
        
        //splitting array for VStack oriented view
        var currentIndex: Int = 0
        
        for object in list {
            gridArray[currentIndex].append(object)
            //incrementing index count and resetting if value goes above columns count
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        
        return gridArray
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showIndicators) {
            HStack(alignment: .top) {
                ForEach(setUpList(), id: \.self.id) { columnsData in
                    LazyVStack(spacing: spacing) {
                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        
    }
}

struct StaggeredGrid_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
