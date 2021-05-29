//
//  ViewModel.swift
//  Test-App
//
//  Created by Adnann Muratovic on 05.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//
import Foundation
import UIKit

struct CellViewModel {
    let image: UIImage
}

class ViewModel {
    // MARK: - Properties

    var result: [Result] = []
   
    var cellViewModels: [CellViewModel] = []
    
    // MARK: - UI
    var isLoading: Bool = false {
        didSet {
            showLoading?()
        }
    }
    
    var showLoading: (() -> Void)?
    var reloadData: (() -> Void)?
    var showError: ((Error) -> Void)?

}
