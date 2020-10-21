//
//  CollectionView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import Combine

struct CollectionView<Content, T>: View where Content: View {
    @State var eachWidth: CGFloat = 0
    @Binding var dataSource: [T]
    let content: (T, Int) -> Content
    
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) -> AnyView in
            let (numberOfColumns, numberOfRows) = getIndexCount(geoWidth: geometry.size.width)
            
            return AnyView(
                ScrollView {
                    VStack {
                        ForEach(0..<numberOfRows, id: \.self) { row in
                            HStack {
                                ForEach(0..<numberOfColumns, id: \.self) { column in
                                    let idx = row * numberOfColumns + column
                                    if let data = elementFor(idx: idx) {
                                        content(data, idx)
                                    } else {
                                        EmptyView().frame(width: 0, height: 0)
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
            )
        }
    }
    
    private func getIndexCount(geoWidth: CGFloat) -> (numberOfColumns: Int, numberOfRows: Int) {
        guard geoWidth > 0 else { return (0, 0) }
        let numberOfColumns: Int = Int(Float(geoWidth) / Float(eachWidth))
        
        guard numberOfColumns > 0 else { return (0, 0) }
        let numberOfRows: Int = (dataSource.count / numberOfColumns) + (dataSource.count % numberOfColumns == 0 ? 0 : 1)
        
        return (numberOfColumns, numberOfRows)
    }
    
    private func elementFor(idx: Int) -> T? {
        guard dataSource.count > idx else { return nil }
        return dataSource[idx]
    }
}
