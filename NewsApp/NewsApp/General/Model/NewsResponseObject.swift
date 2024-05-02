//
//  NewsResponseObject.swift
//  NewsApp
//
//  Created by Darina Kovtun on 18.04.2024.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
