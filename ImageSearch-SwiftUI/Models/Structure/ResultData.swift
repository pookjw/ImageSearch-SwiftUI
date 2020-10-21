//
//  ResultData.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/20/20.
//

import Foundation

final class ResultData: Codable {
    let title: String
    let thumbnailImage: URL?
    let mainImage: URL?
    let docURL: URL?
    
    init(
        title: String,
        thumbnailImage: URL?,
        mainImage: URL?,
        docURL: URL?
    ) {
        self.title = title
        self.thumbnailImage = thumbnailImage
        self.mainImage = mainImage
        self.docURL = docURL
    }
    
    static func getSampleData() -> Self {
        .init(
            title: "Smoothy",
            thumbnailImage: URL(string: "https://lh3.googleusercontent.com/C1D8XmEiJFLaWHvoup34B9srKZ71QRhkow3ovuwYvRnzH647r7JO3eJyynS1yr2Lmg"),
            mainImage: URL(string: "https://lh3.googleusercontent.com/C1D8XmEiJFLaWHvoup34B9srKZ71QRhkow3ovuwYvRnzH647r7JO3eJyynS1yr2Lmg"),
            docURL: URL(string: "https://apps.apple.com/us/app/smoothy-video-chat-for-groups/id1325000338")
        )
    }
}

extension ResultData: Equatable {
    static func ==(lhs: ResultData, rhs: ResultData) -> Bool {
        return lhs.title == rhs.title &&
            lhs.thumbnailImage == rhs.thumbnailImage &&
            lhs.mainImage == rhs.mainImage &&
            lhs.docURL == rhs.docURL
    }
}
