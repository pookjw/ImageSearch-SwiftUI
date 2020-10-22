//
//  DetailedView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct DetailedView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel: DetailedViewModel
    
    init(_ data: ResultData) {
        self.viewModel = .init(data)
    }
    
    var body: some View {
        ZStack {
            KFImage(viewModel.data.mainImage)
                .resizable()
                .scaledToFit()
                .pinchToZoom()
            
            VStack {
                Spacer()
                
                Button(action: { viewModel.showSafari = true }) {
                    ClassicCellView(
                        image: Image(systemName: "safari"),
                        title: Text(viewModel.data.title),
                        description: Text(viewModel.data.docURL?.absoluteString)
                    )
                }
                .padding()
                .background(VisualEffectView(effect: UIBlurEffect(style: colorScheme.uiBlurEffectStyle())))
                .disabled(viewModel.data.docURL == nil)
            }
        }
        .navigationTitle(viewModel.data.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: navBarTrailingItems)
        .sheet(isPresented: $viewModel.showSafari, content: { () -> AnyView in
            guard let url = viewModel.data.docURL else { return AnyView(EmptyView()) }
            return AnyView(SafariView(url: url))
        })
        .alert(isPresented: $viewModel.showPhotoAlert) { photoAlert }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var favoriteButton: some View {
        Button(action: { viewModel.toggleFavorite.send() }) {
            if viewModel.isFavorited {
                Image(systemName: "star.fill")
            } else {
                Image(systemName: "star")
            }
        }
    }
    
    var savePhotoButton: some View {
        Button(action: {
            viewModel.savePhoto.send()
        }) {
            Image(systemName: "square.and.arrow.down")
        }
    }
    
    var navBarTrailingItems: some View {
        HStack {
            savePhotoButton
                .padding()
            favoriteButton
        }
    }
    
    var photoAlert: Alert {
        Alert(
            title: Text("Saved Photo!"),
            dismissButton: .default(Text("Dismiss"))
        )
    }
}

#if DEBUG
struct DetailedView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedView(.getSampleData())
    }
}
#endif
