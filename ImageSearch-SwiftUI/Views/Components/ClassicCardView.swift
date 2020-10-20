//
//  ClassicCardView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ClassicCardView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var gradient: CGFloat
    var topImage: KFImage
    var bottomText: Text
    
    var body: some View {
        VStack(spacing: 0) {
            topImage
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .border(Color.gray, width: 0.5)
            
            
            bottomText
                .font(.system(size: 20))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(getGradientView())
        }
    }
    
    private func getGradientView() -> some View {
        switch colorScheme {
        case .dark:
            return LinearGradient(
                gradient: Gradient(colors: [.black, .white]),
                startPoint: .top,
                endPoint: .init(x: 0.5, y: gradient * 2)
            )
        case .light:
            return LinearGradient(
                gradient: Gradient(colors: [.white, .black]),
                startPoint: .top,
                endPoint: .init(x: 0.5, y: gradient * 2)
            )
        }
    }
}

//struct ClassicCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ClassicCardView(
//                gradient: 3.5,
//                topImage: Image("bear"),
//                bottomText: Text("Bear")
//            )
//                .environment(\.colorScheme, .light)
//                .previewLayout(PreviewLayout.fixed(width: 200, height: 250))
//                .preferredColorScheme(.light)
//
//            ClassicCardView(
//                gradient: 3.5,
//                topImage: Image("bear"),
//                bottomText: Text("Bear")
//            )
//                .environment(\.colorScheme, .dark)
//                .previewLayout(PreviewLayout.fixed(width: 200, height: 250))
//                .preferredColorScheme(.dark)
//        }
//    }
//}
