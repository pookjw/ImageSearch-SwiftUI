//
//  ClassicCellView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import SwiftUI

struct ClassicCellView: View {
    var image: Image
    var title: Text
    var description: Text?
    
    var body: some View {
        HStack {
            image
            VStack {
                title
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if let description = description {
                    description
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
    }
}

struct ClassicCellView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClassicCellView(
                image: Image(systemName: "gearshape"),
                title: Text("Demo"),
                description: Text("Hello World!")
            )
                .previewLayout(.sizeThatFits)
            
            ClassicCellView(
                image: Image(systemName: "gearshape"),
                title: Text("Demo")
            )
                .previewLayout(.sizeThatFits)
        }
    }
}
