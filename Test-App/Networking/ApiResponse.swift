//
//  ApiResponse.swift
//  Test-App
//
//  Created by Adnann Muratovic on 05.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


// MARK: - Models
struct ApiResponse: Codable {
    let total: Int
    let total_pages: Int
    var results: [Result]
}

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}


