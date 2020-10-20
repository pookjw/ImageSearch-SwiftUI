//
//  HomeTabView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct HomeTabView: View {
    var body: some View {
        TabView {
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
        }
    }
}

//struct HomeTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeTabView()
//    }
//}
