//
//  CardView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct CardView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var gradient: CGFloat = 5
    var topImage: KFImage
    var bottomText: Text
    private var data: ResultData
    @State var showStar: Bool
    
    init(_ data: ResultData, showStar: Bool = false) {
        self.data = data
        self.topImage = KFImage(data.thumbnailImage)
        self.bottomText = Text(data.title)
        self._showStar = .init(initialValue: showStar)
    }
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                topImage
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .border(Color.gray, width: 0.3)
                
                bottomText
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(getGradientView())
            }
            
            if showStar {
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .padding([.top, .trailing], 5)
                    }
                    Spacer()
                }
            }
        }
//        .onReceive(FavoritesModel.shared.$favorites, perform: { _ in
//            showStar = FavoritesModel.shared.isFavorited(data)
//        })
    }
    
    public func gradient(_ grad: CGFloat) -> some View {
        self.gradient = grad
        return self
    }
    
    public func applyPresetModifier() -> some View {
        return self
            .frame(width: 150, height: 200)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 0.3)
            )
            .padding([.leading, .trailing, .bottom], 15)
            .shadow(radius: 5, x: 0, y: 15)
    }
    
    private func getGradientView() -> some View {
        switch colorScheme {
        case .dark:
            return LinearGradient(
                gradient: Gradient(colors: [.black, .white]),
                startPoint: .top,
                endPoint: .init(x: 0.5, y: gradient * 2)
            )
        default:
            return LinearGradient(
                gradient: Gradient(colors: [.white, .black]),
                startPoint: .top,
                endPoint: .init(x: 0.5, y: gradient * 2)
            )
        }
    }
}

#if DEBUG
struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(.getSampleData())
                .applyPresetModifier()
                .environment(\.colorScheme, .light)
                .previewLayout(PreviewLayout.fixed(width: 200, height: 250))
                .preferredColorScheme(.light)
            
            CardView(.getSampleData())
                .applyPresetModifier()
                .environment(\.colorScheme, .dark)
                .previewLayout(PreviewLayout.fixed(width: 200, height: 250))
                .preferredColorScheme(.dark)
        }
    }
}
#endif
