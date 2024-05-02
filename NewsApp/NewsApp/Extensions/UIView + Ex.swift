//
//  UIView + Ex.swift
//  NewsApp
//
//  Created by Darina Kovtun on 17.04.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
