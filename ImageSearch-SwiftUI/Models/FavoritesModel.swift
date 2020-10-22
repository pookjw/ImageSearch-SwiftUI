//
//  FavoritesModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import Foundation
import Combine
import WidgetKit

final class FavoritesModel: ObservableObject {
    static let shared: FavoritesModel = .init()
    @Published var favorites: [ResultData]
    var nonPublisherFavorites: [ResultData]
    private var subscriptions = Set<AnyCancellable>()
    private let key: String = "favorites"
    private let userDefaults = UserDefaults(suiteName: "group.com.peter.ImageSearch-SwiftUI")!
    
    init() {
        self.favorites = userDefaults.getObjects(forKey: key)
        self.nonPublisherFavorites = []
        
        $favorites
            .sink(receiveValue: { [weak self] in
                guard let self = self else { return }
                self.userDefaults.setObjects($0, forKey: self.key)
                self.nonPublisherFavorites = $0
                WidgetCenter.shared.reloadTimelines(ofKind: "ImageSearch_SwiftUIWidgetExt")
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
