//
//  Environment+Extensions.swift
//  EBookBrowser
//

import Foundation

extension Environment: BookListRequestFactory {
    func makeFetchBookListRequest(urlString: String) -> BookContent.Request {
        BookContent.request(urlString: urlString)
    }
}

extension Environment: BookListServiceFactory {
    func makeBookListService() -> BookListServiceProtocol {
        BookContent.Service(environment: self)
    }
}
