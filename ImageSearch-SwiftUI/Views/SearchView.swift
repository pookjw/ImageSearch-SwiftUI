//
//  SearchView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @ObservedObject var searchBar: SearchBar
    
    init() {
        self.searchBar = .init()
        self.viewModel = .init()
        
        self.searchBar.textPublisher
            .assign(to: &viewModel.$textPublisher)
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
            .add(searchBar)
            .navigationBarItems(trailing: loadNextButton)
            .navigationTitle(viewModel.textPublisher)
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var loadNextButton: some View {
        Button(action: {
            viewModel.pagePublisher += 1
        }) {
            HStack {
                Image(systemName: "arrowshape.turn.up.right")
                Text("Load Next")
            }
        }.disabled(!viewModel.enabledNextPage)
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
#endif
