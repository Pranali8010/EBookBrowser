//
//  BookListViewFactory.swift
//  EBookBrowser
//

import Foundation

protocol BookListViewFactory {
    func makeBookListView() -> BookListView
}

extension Environment: BookListViewFactory {
    @MainActor
    func makeBookListView() -> BookListView {
        BookListView(
            viewModel: BookListViewModel(environment: self)
        )
    }
}
