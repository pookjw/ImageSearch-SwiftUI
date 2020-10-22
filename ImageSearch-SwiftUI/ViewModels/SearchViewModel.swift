//
//  SearchViewModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {
    @Published var textPublisher: String = ""
    @Published var pagePublisher: Int = 1
    @Published var enabledNextPage: Bool = false
    @Published var dataSource: [ResultData] = []
    
    init() {
        self.bind()
    }
    
    private func bind() {
        var willResetDataSource: Bool = false
        
        Publishers.CombineLatest($textPublisher, $pagePublisher)
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
            .flatMap { SearchModel.shared.searchPublisher(text: $0, page: $1) }
            .replaceError(with: (enabledNextPage, dataSource))
            .filter { _, data in !data.isEmpty }
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
    }
}
