//
//  BookContentService.swift
//  EBookBrowser
//

import Foundation

protocol BookListServiceFactory {
    func makeBookListService() -> BookListServiceProtocol
}

protocol BookListServiceProtocol {
    func fetchBooksData(urlString: String) async -> Result<BookResponse, ResponseError>
}

extension BookContent {
    struct Service: BookListServiceProtocol {
        
        let environment: BookListRequestFactory
        
        func fetchBooksData(urlString: String) async -> Result<BookResponse, ResponseError> {
            await environment
                .makeFetchBookListRequest(urlString: urlString)
                .makeAPICall()
        }
    }
}
