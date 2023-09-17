//
//  Book.swift
//  EBookBrowser
//

import Foundation

struct BookResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Book]
}

struct Book: Codable, Equatable {
    let id: Int
    let title: String
    let authors: [Author]
    let languages: [String]
    
    // MARK: - Equatable
    
    static func == (lhs: Book, rhs: Book) -> Bool {
        lhs.id == rhs.id
    }
    
    var authorName: String {
        authors.first?.name ?? ""
    }
    
    var availableLanguages: String {
        languages.joined(separator: ", ")
    }
}

struct Author: Codable {
    let name: String
    let birthYear: Int?
    let deathYear: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}
