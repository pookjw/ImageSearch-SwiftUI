//
//  SearchView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import Combine

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var title: String = "Search"
    @State var dataSource: [CollectionViewData] = []
    @ObservedObject var searchBar: SearchBar
    
    init() {
        self.searchBar = .init()
        self.viewModel = .init()
        
        self.searchBar.textPublisher
            .assign(to: &self.viewModel.$inputPublisher)
    }
    
    var body: some View {
        NavigationView {
            CollectionView(eachWidth: 170, dataSource: self.$dataSource) { (data, idx) -> AnyView in
                AnyView(
                    ClassicCardView(
                        gradient: 5,
                        topImage: data.image,
                        bottomText: data.title
                    )
                    .frame(width: 150, height: 200)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
                    )
                    .padding([.leading, .trailing, .bottom], 15)
                    .shadow(radius: 10, x: 0, y: 10)
                )
            }
            .add(searchBar)
            .navigationTitle(title)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(viewModel.$dataSource, perform: { sources in
            self.dataSource = sources
        })
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
