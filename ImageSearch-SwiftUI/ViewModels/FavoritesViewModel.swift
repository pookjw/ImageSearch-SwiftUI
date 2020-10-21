//
//  FavoritesViewModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import Foundation
import Combine

final class FavoritesViewModel: ObservableObject {
    @Published var dataSource: [ResultData] = []
    
    init() {
        FavoritesModel
            .shared
            .$favorites
            .assign(to: &$dataSource)
    }
}
