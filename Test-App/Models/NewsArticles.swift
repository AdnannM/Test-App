//
//  NewsArticles.swift
//  Test-App
//
//  Created by Adnann Muratovic on 26.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


struct NewsArticles: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String
}

struct Source: Codable {
    let name: String
}
