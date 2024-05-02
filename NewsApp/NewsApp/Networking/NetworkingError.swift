//
//  NetworkingError.swift
//  NewsApp
//
//  Created by Darina Kovtun on 18.04.2024.
//

import Foundation

enum NetworkingError: Error {
    case networkingError(_ error: Error)
    case unknown
}
