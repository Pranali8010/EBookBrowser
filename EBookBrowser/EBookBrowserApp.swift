//
//  EBookBrowserApp.swift
//  EBookBrowser
//

import SwiftUI

@main
struct EBookBrowserApp: App {
    var body: some Scene {
        WindowGroup {
            Environment
                .shared
                .makeBookListView()
        }
    }
}
