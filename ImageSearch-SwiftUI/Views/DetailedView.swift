//
//  DetailedView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import SwiftUI
import struct Kingfisher.KFImage

struct DetailedView: View {
    @ObservedObject var viewModel: DetailedViewModel
    @State var isFavorited: Bool = false
    
    var body: some View {
        VStack {
            KFImage(viewModel.data.mainImage)
                .resizable()
                .scaledToFit()
            
            Button(action: { viewModel.showSafari = true }) {
                ClassicCellView(
                    image: Image(systemName: "safari"),
                    title: Text(viewModel.data.title),
                    description: Text(viewModel.data.docURL?.absoluteString)
                )
            }
            .padding()
            .disabled(viewModel.data.docURL == nil)
            
            Spacer()
        }
        .navigationTitle(viewModel.data.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: navigationBarButton)
        .sheet(isPresented: $viewModel.showSafari, content: { () -> AnyView in
            guard let url = viewModel.data.docURL else { return AnyView(EmptyView()) }
            return AnyView(SafariView(url: url))
        })
        .onReceive(FavoritesModel.shared.$favorites, perform: { _ in
            isFavorited = FavoritesModel.shared.isFavorited(viewModel.data)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var navigationBarButton: some View {
        Button(action: { FavoritesModel.shared.toggleFavorite(viewModel.data) }) {
            if isFavorited {
                Image(systemName: "star.fill")
            } else {
                Image(systemName: "star")
            }
        }
    }
}

//struct DetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailedView(data: .getSampleData())
//    }
//}
