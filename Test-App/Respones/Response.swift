//
//  Response.swift
//  Test-App
//
//  Created by Adnann Muratovic on 22.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


struct Response: Decodable {
    var items: [Video]?
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    init (from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Video].self, forKey: .items)
    }
}
