//
//  KakaoSearchData.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/20/20.
//

import Foundation

struct KakaoSearchData: Decodable {
    let meta: Meta
    let documents: [Documents]
    
    struct Meta: Decodable {
        let total_count: Int
        let pageable_count: Int
        let is_end: Bool
    }
    
    struct Documents: Decodable {
        let collection: String
        let thumbnail_url: String
        let image_url: String
        let width: Int
        let height: Int
        let display_sitename: String
        let doc_url: String
    }
}
