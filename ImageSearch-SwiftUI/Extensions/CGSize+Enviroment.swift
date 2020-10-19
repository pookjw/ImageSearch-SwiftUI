//
//  CGSize+Enviroment.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

extension CGSize: EnvironmentKey {
    public static var defaultValue: Binding<CGSize> = .constant(.zero)
}

extension EnvironmentValues {
    var cgSize: Binding<CGSize> {
        get { self[CGSize.self] }
        set { self[CGSize.self] = newValue }
    }
}
