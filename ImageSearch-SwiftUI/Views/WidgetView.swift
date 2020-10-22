//
//  WidgetView.swift
//  ImageSearch-SwiftUIWidgetExtExtension
//
//  Created by Jinwoo Kim on 10/22/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct WidgetView: View {
    @State var favorites: [ResultData]
    var body: some View {
        Link(destination: URL(string: "imagesearch://")!) {
            return KFImage((favorites.last ?? ResultData.getSampleData()).mainImage)
                .resizable()
                .scaledToFill()
        }
        .widgetURL(URL(string: "imagesearch://"))
    }
}

#if DEV
struct WidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WidgetView(favorites: [.getSampleData()])
    }
}
#endif
