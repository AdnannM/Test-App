//
//  CustomSpinner.swift
//  Test-App
//
//  Created by Adnann Muratovic on 19.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


import UIKit

// MARK: - Spinner Animation
fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView?.backgroundColor = UIColor(red: 0.5,
                                         green: 0.5,
                                         blue: 0.5,
                                         alpha: 0.5)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = aView!.center
        ai.startAnimating()
        aView?.addSubview(ai)
        self.view.addSubview(aView!)
        
    }
    
    func removeSpinner() {
        aView?.removeFromSuperview()
        
        // clean memory
        aView = nil
        
    }
}
