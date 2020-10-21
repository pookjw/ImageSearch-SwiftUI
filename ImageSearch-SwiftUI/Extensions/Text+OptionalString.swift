//
//  Text+OptionalString.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import SwiftUI

extension Text {
    init?<T>(_ content: T?) where T: StringProtocol {
        guard let wrapped = content else { return nil }
        self = Self.init(wrapped)
    }
}
