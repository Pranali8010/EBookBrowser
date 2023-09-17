//
//  BookListViewModelTests.swift
//  EBookBrowserTests
//

import XCTest
@testable import EBookBrowser

final class BookListViewModelTests: XCTestCase {

    private lazy var mockEnvironment = MockEnvionment()
    private lazy var viewModel = BookListViewModel(environment: mockEnvironment)
    
    override func setUp() {
        mockEnvironment = MockEnvionment()
        viewModel = BookListViewModel(environment: mockEnvironment)
    }

    func testFetchBooks() async {
        XCTAssertTrue(viewModel.bookList.isEmpty)
        await viewModel.fetchBooks()
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books"
        )
        XCTAssertFalse(viewModel.bookList.isEmpty)
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
    }
    
    func testBookListPagination() async {
        XCTAssertTrue(viewModel.bookList.isEmpty)
        await viewModel.fetchBooks()
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books"
        )
        
        await viewModel
            .fetchNextPageIfRequired(
                lastItem: Book(
                    id: 4,
                    title: "A Room with a View",
                    authors: [
                        Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                    ],
                    languages: ["en"]
                )
            )
        
        XCTAssertEqual(
            viewModel.bookList.count,
            8
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            2
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books/?page=2"
        )
    }
    
    func testPaginationFalseCondition() async {
        XCTAssertTrue(viewModel.bookList.isEmpty)
        await viewModel.fetchBooks()
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books"
        )
        
        // Pagination request with second last item of current page
        await viewModel
            .fetchNextPageIfRequired(
                lastItem: Book(
                    id: 3,
                    title: "Moby Dick; Or, The Whale",
                    authors: [
                        Author(name: "Melville", birthYear: 1819, deathYear: 1891)
                    ],
                    languages: ["en"]
                )
            )
        
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        
        // Pagination request with last item of current page
        await viewModel
            .fetchNextPageIfRequired(
                lastItem: Book(
                    id: 4,
                    title: "A Room with a View",
                    authors: [
                        Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                    ],
                    languages: ["en"]
                )
            )
        
        XCTAssertEqual(
            viewModel.bookList.count,
            8
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            2
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books/?page=2"
        )
        
        // Pagination request with last item of the total response
        await viewModel
            .fetchNextPageIfRequired(
                lastItem: Book(
                    id: 8,
                    title: "Song of Ice and Fire",
                    authors: [
                        Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                    ],
                    languages: ["en"]
                )
            )
        
        XCTAssertEqual(
            viewModel.bookList.count,
            8
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            2
        )
    }
    
    func testResponseFailure() async {
        mockEnvironment.bookListService.result = .failure(.badUrl)
        
        XCTAssertTrue(viewModel.bookList.isEmpty)
        await viewModel.fetchBooks()
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books"
        )
        XCTAssertTrue(viewModel.bookList.isEmpty)
    }
    
    func testFetchDataWithInvalidUrl() async {
        mockEnvironment.bookListService.result = .success(BookResponse.mockResponseWithInvalideUrl)
        
        XCTAssertTrue(viewModel.bookList.isEmpty)
        await viewModel.fetchBooks()
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.urlString,
            "https://gutendex.com/books"
        )
        
        await viewModel
            .fetchNextPageIfRequired(
                lastItem: Book(
                    id: 4,
                    title: "A Room with a View",
                    authors: [
                        Author(name: "Forster", birthYear: 1879, deathYear: 1970)
                    ],
                    languages: ["en"]
                )
            )
        
        XCTAssertEqual(
            viewModel.bookList.count,
            4
        )
        XCTAssertEqual(
            mockEnvironment.bookListService.fetchBooksDataCount,
            1
        )
    }
}
