//
//  DetailedViewModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import UIKit
import Combine

final class DetailedViewModel: ObservableObject {
    var data: ResultData
    @Published var showSafari: Bool = false
    @Published var showPhotoAlert: Bool = false
    @Published var isFavorited: Bool = false
    var savePhoto: PassthroughSubject<Void, Never> = .init()
    var toggleFavorite: PassthroughSubject<Void, Never> = .init()
    private var subscriptions = Set<AnyCancellable>()
    
    init(_ data: ResultData) {
        self.data = data
        
        FavoritesModel
            .shared
            .$favorites
            .sink(receiveValue: { [weak self ]_ in
                guard let self = self else { return }
                self.isFavorited = FavoritesModel
                    .shared
                    .isFavorited(self.data)
            })
            .store(in: &subscriptions)
        
        savePhoto
            .flatMap { _ in
                Just(data.mainImage)
                    .compactMap { $0 }
                    .tryMap { try Data(contentsOf: $0) }
                    .map { UIImage(data: $0) }
                    .replaceError(with: nil)
                    .compactMap { $0 }
                    .flatMap {
                        PhotoWriter.save($0)
                    }
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .finished = completion {
                    self.showPhotoAlert = true
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
        
        toggleFavorite
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.isFavorited = FavoritesModel
                    .shared
                    .toggleFavorite(self.data)
            }
            .store(in: &subscriptions)
    }
}
