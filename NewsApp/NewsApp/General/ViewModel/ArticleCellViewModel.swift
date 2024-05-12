//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Darina Kovtun on 18.04.2024.
//

import UIKit

final class ArticleCellViewModel: TableCollectionViewItemsProtocol {
    let title: String
    let description: String
    let imageUrl: String?
    var imageData: Data?
    var date: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description ?? ""
        date = article.publishedAt
        imageUrl = article.urlToImage
        
        if let formatDate = formatDate(dateString: self.date) {
            self.date = formatDate
        }
    }
    
    private func formatDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "dd MMM yyyy HH:mm"
        return dateFormatter.string(from: date)
    }
}
