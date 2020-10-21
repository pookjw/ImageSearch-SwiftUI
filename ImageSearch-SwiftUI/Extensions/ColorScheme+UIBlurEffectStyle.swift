//
//  ColorScheme+UIBlurEffectStyle.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

import SwiftUI

extension ColorScheme {
    func uiBlurEffectStyle() -> UIBlurEffect.Style {
        switch self {
        case .dark:
            return .dark
        default:
            return .light
        }
    }
}
