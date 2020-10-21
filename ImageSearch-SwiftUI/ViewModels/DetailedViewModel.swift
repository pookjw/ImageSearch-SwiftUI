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
    }
    
    func toggleFavorite() {
        // 원래 `isFavorited = `를 안 적어도 isFavorited이 변경이 돼야 하는데... 버그인지 안 바뀌어서 적어줌...
        isFavorited = FavoritesModel
            .shared
            .toggleFavorite(data)
    }
    
    func savePhoto() {
        Just(data.mainImage)
            .compactMap { $0 }
            .tryMap { try Data(contentsOf: $0) }
            .map { UIImage(data: $0) }
            .replaceError(with: nil)
            .compactMap { $0 }
            .flatMap {
                PhotoWriter.save($0)
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .finished = completion {
                    self.showPhotoAlert = true
                }
            }, receiveValue: { _ in })
            .store(in: &subscriptions)
    }
}
