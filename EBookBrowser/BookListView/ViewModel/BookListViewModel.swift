//
//  BookListViewModel.swift
//  EBookBrowser
//

import Foundation

final class BookListViewModel: ObservableObject {
    
    @Published var bookList: [Book] = []
    @Published var shouldHideProgressView: Bool = false
     
    // MARK: - Private variables
    
    private var count = 0
    
    private var nextPageUrlString: String?
    
    private let environment: BookListServiceFactory
    
    init(environment: BookListServiceFactory) {
        self.environment = environment
    }
    
    func fetchBooks(fetchNextPage: Bool = false) async {
        let firstPageUrlString = "https://gutendex.com/books"
        let urlString = fetchNextPage ? nextPageUrlString : firstPageUrlString
        
        guard let urlString else { return }
        
        let result = await environment
            .makeBookListService()
            .fetchBooksData(urlString: urlString)
        
        switch result {
        case let .success(bookResponse):
            count = bookResponse.count
            nextPageUrlString = bookResponse.next
            await loadBooks(books: bookResponse.results)
            
        case .failure:
            // Error handling
            break
        }
    }
    
    func fetchNextPageIfRequired(lastItem: Book) async {
        if bookList.last == lastItem &&
            count > bookList.count {
            await fetchBooks(fetchNextPage: true)
        }
    }
    
    @MainActor
    private func loadBooks(books: [Book]) {
        bookList.append(contentsOf: books)
        shouldHideProgressView = true
    }
}

