//
//  FavoritesView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

struct FavoritesView: View {
    var body: some View {
        ScrollView {
            
            ClassicCardView(
                gradient: 3.5,
                topImage: Image("bear"),
                bottomText: Text("Bear")
            )
            .frame(width: 300, height: 350)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.7), lineWidth: 0.5)
            )
            .padding([.leading, .trailing], 10)
            .shadow(radius: 10, x: 0, y: 10)
            
            ClassicCardView(
                gradient: 3.5,
                topImage: Image("monkey"),
                bottomText: Text("Monkey")
            )
            .frame(width: 300, height: 350)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 0.5)
            )
            .padding([.leading, .trailing], 10)
            .shadow(radius: 10, x: 0, y: 10)
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
