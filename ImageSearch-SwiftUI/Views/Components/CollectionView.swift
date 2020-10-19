//
//  CollectionView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct CollectionView<Content, T>: View where Content: View {
    var eachWidth: CGFloat
    var dataSource: [T]
    let content: (T) -> Content
    
    init(
        eachWidth: CGFloat,
        dataSource: [T],
        @ViewBuilder content: @escaping (T) -> Content
    ) {
        self.eachWidth = eachWidth
        self.dataSource = dataSource
        self.content = content
    }
    
    // Swift 컴파일러 버그를 임시로 우회하는 코드를 넣어서 코드가 깔끔하지 않음
    var body: some View {
        GeometryReader { (geometry: GeometryProxy) -> AnyView in
            let (numberOfColumns, numberOfRows) = getIndexCount(geoWidth: geometry.size.width)
            
            AnyView(
                ScrollView {
                    ForEach(0..<numberOfRows) { row in
                        HStack {
                            ForEach(0..<numberOfColumns) { column in
                                if let data = 
                            }
                        }
                    }
                }
            )
        }
    }
    
    private func getIndexCount(geoWidth: CGFloat) -> (numberOfColumns: Int, numberOfRows: Int) {
        let column: Int = Int(Float(geoWidth) / Float(eachWidth))
        let row: Int = (dataSource.count / column) + (dataSource.count % column == 0 ? 0 : 1)
        return (column, row)
    }
    
    private func elementFor(row: Int, column: Int) -> T? {
        guard dataSource.count > row * column else { return nil }
        return dataSource[row * column]
    }
}

//struct CollectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        CollectionView()
//    }
//}
