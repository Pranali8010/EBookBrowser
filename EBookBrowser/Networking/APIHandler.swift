//
//  APIHandler.swift
//  EBookBrowser
//

import Foundation

enum ResponseError: Error, Equatable {
    case badUrl
    case error(Error)
    
    static func == (lhs: ResponseError, rhs: ResponseError) -> Bool {
        switch (lhs, rhs) {
        case (.badUrl, .badUrl):
            return true
            
        case let (.error(error1), .error(error2)):
            let err1 = error1 as NSError
            let err2 = error2 as NSError
            return err1.code == err2.code
                && err1.domain == err2.domain
                && err1.description == err2.description
            
        default:
            return false
        }
    }
}

struct APIHandler<Success: Codable, Failure: Error> {
    let urlString: String
    
    func makeAPICall() async -> Result<Success, ResponseError> {
        guard let url = URL(string: urlString)
        else {
            return .failure(.badUrl)
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let parsedData = try JSONDecoder().decode(Success.self, from: data)
            return .success(parsedData)
        } catch {
            return .failure(.error(error))
        }
    }
}
