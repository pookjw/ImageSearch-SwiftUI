//
//  SafariView.swift
//  ImageSearch-SwiftUI
//
//  Created by Jinwoo Kim on 10/21/20.
//

/* https://stackoverflow.com/a/59448652 */

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
}
