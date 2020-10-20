//
//  SearchViewModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage

final class SearchViewModel: ObservableObject {
    @Published var inputPublisher: String = ""
    @Published var dataSource: [CollectionViewData] = []
    
    init() {
        self.bind()
    }
    
    private var searchModel = SearchModel()
    
    private func bind() {
        searchModel.searchPublisher(inputPublisher: $inputPublisher.eraseToAnyPublisher())
            .map { resultData -> [CollectionViewData] in
                resultData
                    .documents
                    .map { document -> CollectionViewData in
                        .init(
                            title: Text(document.display_sitename),
                            image: KFImage(URL(string: document.thumbnail_url)!)
                        )
                    }
            }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: &self.$dataSource)
    }
}
