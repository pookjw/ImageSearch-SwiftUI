//
//  ImageSearch_SwiftUIApp.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/19/20.
//

import SwiftUI

@main
struct ImageSearch_SwiftUIApp: App {
    @State private var showSheet: Bool = false
    var body: some Scene {
        WindowGroup {
            MainView(showSheet: $showSheet)
                .onAppear(perform: {
                    UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                })
                .onOpenURL(perform: { _ in
                    showSheet = true
                })
        }
    }
}
