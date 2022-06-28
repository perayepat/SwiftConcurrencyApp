//
//  SFSafariViewWrapper.swift
//  SwiftConcurrency
//
//  Created by IACD-013 on 2022/06/28.
//

import SwiftUI
import SafariServices

//create a safari browser inside the app

struct SFSafariViewWrapper: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<Self>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SFSafariViewWrapper>) {
        return
    }
}
