//
//  TableCollectionViewSection.swift
//  NewsApp
//
//  Created by Darina Kovtun on 08.05.2024.
//

import Foundation

protocol TableCollectionViewItemsProtocol { }

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemsProtocol]
}
