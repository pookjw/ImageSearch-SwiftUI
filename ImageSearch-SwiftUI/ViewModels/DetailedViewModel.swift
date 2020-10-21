//
//  DetailedViewModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import Foundation
import Combine

final class DetailedViewModel: ObservableObject {
    var data: ResultData
    @Published var showSafari: Bool = false
    
    init(data: ResultData) {
        self.data = data
    }
}
