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
    @Published var textPublisher: String = ""
    @Published var pagePublisher: Int = 1
    @Published var enabledNextPage: Bool = false
    @Published var dataSource: [ResultData] = []
    
    init() {
        self.bind()
    }
    
    private var searchModel = SearchModel()
    
    private func bind() {
        var willResetDataSource: Bool = false
        
        let inputPublisher = Publishers.CombineLatest($textPublisher, $pagePublisher)
            .eraseToAnyPublisher()
            .filter { $0.0 != "" && $0.1 > 0 }
            .removeDuplicates { [weak self] old, new in
                guard let self = self else { return true }
                guard old != new else { return true }
                
                if old.0 != new.0 {
                    willResetDataSource = true
                    self.pagePublisher = 1
                } else {
                    willResetDataSource = false
                }
                return false
            }
            .eraseToAnyPublisher()
        
        let resultPublisher = searchModel.searchPublisher(inputPublisher)
            .replaceError(with: (enabledNextPage, dataSource))
            .filter { _, data in !data.isEmpty }
            
        resultPublisher
            .receive(on: DispatchQueue.main)
            .map { [weak self] (enabled, data) -> [ResultData] in
                guard let self = self else { return data }
                self.enabledNextPage = enabled
                if !willResetDataSource {
                    let appendedData = self.dataSource + data
                    return appendedData
                }
                return data
            }
            .assign(to: &$dataSource)
        
//        resultPublisher
//            .map(\.0)
//            .assign(to: &$enabledNextPage)
    }
}
