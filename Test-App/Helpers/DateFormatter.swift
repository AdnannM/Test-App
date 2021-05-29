//
//  DateFormatter.swift
//  Test-App
//
//  Created by Adnann Muratovic on 20.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


// MARK: - Formatter Date to String


extension Date {
    
    
    func longDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyyHHmmss"
        return dateFormatter.string(from: self)
    }
    
}
