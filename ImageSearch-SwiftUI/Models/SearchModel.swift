//
//  SearchModel.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/20/20.
//

import SwiftUI
import Combine
import struct Kingfisher.KFImage

final class SearchModel {
    private var apiKey: String = "dff576e28ce434796a2329a6a2366d76"
    private var apiUrl: URL = URL(string: "https://dapi.kakao.com/v2/search/image")!
    
    enum Error: Swift.Error {
        case network
        case json
    }
    
    func searchPublisher(_ inputPublisher: AnyPublisher<(String, Int), Never>) -> AnyPublisher<(Bool, [CollectionViewData]), Error> {
        inputPublisher
            .flatMap { [weak self] (text: String, page: Int) -> AnyPublisher<ResultData, SearchModel.Error> in
                guard let self = self else {
                    return Fail(error: SearchModel.Error.network)
                        .eraseToAnyPublisher()
                }
                
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
                    .map(\.data)
                    .decode(type: ResultData.self, decoder: JSONDecoder())
                    .mapError { _ in return Error.json }
                    .eraseToAnyPublisher()
            }
            .map { resultData -> (Bool, [CollectionViewData]) in
                let data = resultData
                    .documents
                    .map { document -> CollectionViewData in
                        .init(
                            title: Text(document.display_sitename == "" ? self.randomEmoji() : document.display_sitename),
                            image: KFImage(URL(string: document.thumbnail_url)!)
                        )
                    }
                return (!resultData.meta.is_end, data)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func randomEmoji() -> String{
        let emojiStart = 0x1F601
        let ascii = emojiStart + Int(arc4random_uniform(UInt32(35)))
        let emoji = UnicodeScalar(ascii)?.description
        return emoji ?? "😱"
    }
}
