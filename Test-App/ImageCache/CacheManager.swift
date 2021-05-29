//
//  CacheManager.swift
//  Test-App
//
//  Created by Adnann Muratovic on 22.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation

class CactheManager {
    
    static var cache = [String: Data]()
    
    static func setVideoCache(_ url: String, _ data: Data?) {
        
        // Store the image data and use the url as the key
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        
        // Try to get data
        return cache[url]
        
    }
}
