//
//  BookListView.swift
//  EBookBrowser
//

import SwiftUI

struct BookListView: View {
    
    // MARK: - Observable Properties
    
    @ObservedObject
    private var viewModel: BookListViewModel
    
    // MARK: - Init
    
    init(viewModel: BookListViewModel) {
        self.viewModel = viewModel
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemTeal]
        UINavigationBar
            .appearance()
            .titleTextAttributes = [.foregroundColor: UIColor.systemTeal]
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            List {
                ForEach(
                    viewModel.bookList,
                    id: \.id
                ) { rowItem in
                    BookRowView(book: rowItem)
                        .onAppear {
                            Task {
                                await viewModel
                                    .fetchNextPageIfRequired(lastItem: rowItem)
                            }
                        }
                }
            }
            .navigationTitle("E Book browser")
        }
        .task {
            await viewModel.fetchBooks()
        }
        .preferredColorScheme(.dark)
    }
}
