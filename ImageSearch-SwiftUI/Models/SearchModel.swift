//
//  SearchModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/20/20.
//

import Foundation
import Combine

final class SearchModel {
    private var apiKey: String = "dff576e28ce434796a2329a6a2366d76"
    private var apiUrl: URL = URL(string: "https://dapi.kakao.com/v2/search/image")!
    
    static let shared: SearchModel = .init()
    
    enum Error: Swift.Error {
        case network
        case json
    }
    
    func searchPublisher(text: String, page: Int) -> AnyPublisher<(Bool, [ResultData]), Error> {
        guard var components = URLComponents(url: self.apiUrl, resolvingAgainstBaseURL: true) else {
            return Fail(error: SearchModel.Error.network)
                .eraseToAnyPublisher()
        }
        
        components.queryItems = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let finalURL = components.url else {
            return Fail(error: SearchModel.Error.network)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: finalURL)
        request.setValue("KakaoAK \(self.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        return URLSession
            .shared
            .dataTaskPublisher(for: request)
            .eraseToAnyPublisher()
            .map(\.data)
            .decode(type: KakaoSearchData.self, decoder: JSONDecoder())
            .mapError { _ in return Error.json }
            .eraseToAnyPublisher()
            .map { resultData -> (Bool, [ResultData]) in
                let data = resultData
                    .documents
                    .map { document -> ResultData in
                        let data = ResultData(
                            title: document.display_sitename == "" ? self.randomEmoji() : document.display_sitename,
                            thumbnailImage: URL(string: document.thumbnail_url),
                            mainImage: URL(string: document.image_url),
                            docURL: URL(string: document.doc_url)
                        )
                        return FavoritesModel.shared.getFavoritedReference(data) ?? data
                    }
                return (!resultData.meta.is_end, data)
            }
            .eraseToAnyPublisher()
    }
    
    private func randomEmoji() -> String{
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
        let emoji = UnicodeScalar(ascii)?.description
        return emoji ?? "😱"
    }
}
