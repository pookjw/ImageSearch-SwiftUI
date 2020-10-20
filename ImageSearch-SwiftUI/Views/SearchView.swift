//
//  SearchView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import Combine

struct SearchView: View {
    @State var title: String = "Search"
    @State var dataSource: [CollectionViewData] = []
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
            CollectionView(eachWidth: 180, dataSource: self.$dataSource) { (data, idx) -> AnyView in
                AnyView(
                    CardView(
                        gradient: 5,
                        topImage: data.image,
                        bottomText: data.title
                    )
                    .frame(width: 150, height: 200)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.gray.opacity(0.7), lineWidth: 0.3)
                    )
                    .padding([.leading, .trailing, .bottom], 15)
                    .shadow(radius: 15, x: 0, y: 15)
                )
            }
            .add(searchBar)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        viewModel.pagePublisher += 1
                                    }) {
                                        HStack {
                                            Image(systemName: "arrowshape.turn.up.right")
                                            Text("Load Next")
                                        }
                                    }.disabled(!viewModel.enabledNextPage)
            )
            .navigationTitle(viewModel.textPublisher)
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onReceive(viewModel.$dataSource, perform: { sources in
            self.dataSource = sources
        })
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//    }
//}
