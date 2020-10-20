//
//  ImageSearch_SwiftUIApp.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

@main
struct ImageSearch_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            HomeTabView()
                .onAppear(perform: {
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                })
        }
    }
}
