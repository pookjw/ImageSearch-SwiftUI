//
//  FavoritesModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import Foundation
import Combine

final class FavoritesModel: ObservableObject {
    static let shared: FavoritesModel = .init()
    @Published var favorites: [ResultData]
    private var subscriptions = Set<AnyCancellable>()
    private let key: String = "favorites"
    
    init() {
        self.favorites = UserDefaults.standard.getObjects(forKey: key)
        
        $favorites
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                UserDefaults.standard.setObjects($0, forKey: self.key)
            })
            .store(in: &subscriptions)
    }
    
    func isFavorited(_ data: ResultData) -> Bool {
        favorites.contains(data)
    }
    
    func getFavoritedReference(_ data: ResultData) -> ResultData? {
        guard let idx = favorites.firstIndex(of: data) else {
            return nil
        }
        return favorites[idx]
    }
    
    @discardableResult
    func toggleFavorite(_ data: ResultData) -> Bool {
        if let idx = favorites.firstIndex(of: data) {
            favorites.remove(at: idx)
            return false
        } else {
            favorites.append(data)
            return true
        }
    }
}
