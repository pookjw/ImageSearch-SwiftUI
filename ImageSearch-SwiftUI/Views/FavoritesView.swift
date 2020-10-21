//
//  FavoritesView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: FavoritesViewModel
    
    init() {
        self.viewModel = .init()
    }
    
    var body: some View {
        NavigationView {
            CollectionView(eachWidth: 180, dataSource: $viewModel.dataSource) { (data, idx) in
                NavigationLink(
                    destination: DetailedView(data)
                ) {
                    CardView(data)
                        .applyPresetModifier()
                }
            }
            .navigationTitle(Text("Favorites"))
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if DEBUG
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
#endif
