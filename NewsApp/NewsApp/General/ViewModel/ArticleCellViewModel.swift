//
//  ArticleCellViewModel.swift
//  NewsApp
//
//  Created by Darina Kovtun on 18.04.2024.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.publishedAt
        imageUrl = article.urlToImage
    }
}
