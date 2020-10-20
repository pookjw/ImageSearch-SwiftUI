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
    
    enum Error: Swift.Error {
        case network
        case json
    }
    
    func searchPublisher(inputPublisher: AnyPublisher<String, Never>) -> AnyPublisher<ResultData, SearchModel.Error> {
        inputPublisher
            .filter { $0 != "" }
            .flatMap { [weak self] (text: String) -> AnyPublisher<ResultData, SearchModel.Error> in
                
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
                    URLQueryItem(name: "page", value: "1")
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
            .eraseToAnyPublisher()
    }
    
    
}
