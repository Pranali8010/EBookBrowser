//
//  MockEnvironment.swift
//  EBookBrowserTests
//

@testable import EBookBrowser

private typealias Environment = BookListServiceFactory

// MARK: - Mock MockEnvironment

final class MockEnvionment: Environment {
    
    let bookListService = MockBookListService()
    
    // MARK: - Mock BookListServiceFactory
    
    var makeBookListServiceCount = 0
    func makeBookListService() -> BookListServiceProtocol {
        makeBookListServiceCount += 1
        return bookListService
    }
}

// MARK: - Extension Mock BookListService

final class MockBookListService: BookListServiceProtocol {
        
    var result: Result<BookResponse, ResponseError> = .success(.mockFirstPage)
    var fetchBooksDataCount = 0
    var urlString = ""
    
    func fetchBooksData(urlString: String) async -> Result<BookResponse, ResponseError> {
        fetchBooksDataCount += 1
        self.urlString = urlString

        if urlString.contains("2") {
            return .success(.mockSecondPage)
        } else {
            return result
        }
    }
}

// MARK: - Extension BookResponse mocks

extension BookResponse {
    static var mockFirstPage: BookResponse {
        .init(
            count: 8,
            next: "https://gutendex.com/books/?page=2",
            previous: nil,
            results: Book.mockBookListPage1
        )
    }
    
    static var mockSecondPage: BookResponse {
        .init(
            count: 8,
            next: "https://gutendex.com/books/?page=3",
            previous: "https://gutendex.com/books/?page=2",
            results: Book.mockBookListPage1
        )
    }
    
    static var mockResponseWithInvalideUrl: BookResponse {
        .init(
            count: 8,
            next: nil,
            previous: nil,
            results: Book.mockBookListPage1
        )
    }
}

// MARK: - Extension Book mocks

private extension Book {
    static var mockBookListPage1: [Book] {
        [
            Book(
                id: 1,
                title: "Romeo and Juliet",
                authors: [
                    Author(name: "Shakespeare", birthYear: 1909, deathYear: 1970)
                ],
                languages: ["en"]
            ),
            Book(
                id: 2,
                title: "Two states",
                authors: [
                    Author(name: "Chetan Bhagat", birthYear: 1950, deathYear: nil)
                ],
                languages: ["en"]
            ),
            Book(
                id: 3,
                title: "Moby Dick; Or, The Whale",
                authors: [
                    Author(name: "Melville", birthYear: 1819, deathYear: 1891)
                ],
                languages: ["en"]
            ),
            Book(
                id: 4,
                title: "A Room with a View",
                authors: [
                    Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                ],
                languages: ["en"]
            )
        ]
    }
    
    static var mockBookListPage2: [Book] {
        [
            Book(
                id: 5,
                title: "Mahabharat",
                authors: [
                    Author(name: "Shakespeare", birthYear: 1909, deathYear: 1970)
                ],
                languages: ["en"]
            ),
            Book(
                id: 6,
                title: "Ramayan",
                authors: [
                    Author(name: "Chetan Bhagat", birthYear: 1950, deathYear: nil)
                ],
                languages: ["en"]
            ),
            Book(
                id: 7,
                title: "Lord of the Rings",
                authors: [
                    Author(name: "Melville", birthYear: 1819, deathYear: 1891)
                ],
                languages: ["en"]
            ),
            Book(
                id: 8,
                title: "Song of Ice and Fire",
                authors: [
                    Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                ],
                languages: ["en"]
            )
        ]
    }
}
