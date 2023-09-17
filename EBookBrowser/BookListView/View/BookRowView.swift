//
//  BookRowView.swift
//  EBookBrowser
//

import SwiftUI

struct BookRowView: View {
    // MARK: - Private properties
    
    private let book: Book
    
    // MARK: - Init
    
    init(book: Book) {
        self.book = book
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(book.title)
                .font(Font.system(size: 18.0, weight: .semibold))
                .foregroundColor(Color.lightBlue)
            
            HStack {
                Text(book.authorName)
                    .font(Font.system(size: 12.0, weight: .medium))
                    .foregroundColor(Color.gray)

                Spacer()
                
                Text(book.availableLanguages)
                    .font(Font.system(size: 12.0, weight: .regular))
                    .foregroundColor(Color.gray)
            }
        }
    }
}
