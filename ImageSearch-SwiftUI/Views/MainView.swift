//
//  MainView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct MainView: View {
    @Binding var showSheet: Bool
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
        .sheet(isPresented: $showSheet) {
            NavigationView { DetailedView(FavoritesModel.shared.favorites.last ?? .getSampleData())
                    .navigationBarItems(trailing: dismissSheetButton)
            }
        }
    }
    
    var dismissSheetButton: some View {
        Button(action: { showSheet = false }, label: {
            Text("Done")
        })
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(showSheet: .constant(false))
    }
}
#endif
