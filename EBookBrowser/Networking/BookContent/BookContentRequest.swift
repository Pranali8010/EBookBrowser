//
//  BookContentRequest.swift
//  EBookBrowser
//

import Foundation

protocol BookListRequestFactory {
    func makeFetchBookListRequest(urlString: String) -> APIHandler<BookResponse, ResponseError>
}

struct BookContent {
    typealias Request = APIHandler<BookResponse, ResponseError>
    
    static func request(urlString: String) -> Request {
        Request(urlString: urlString)
    }
}
