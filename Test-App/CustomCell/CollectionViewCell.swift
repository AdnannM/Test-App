//
//  CollectionViewCell.swift
//  Test-App
//
//  Created by Adnann Muratovic on 05.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewCell: UIImageView! {
        didSet {
            imageViewCell.layer.cornerRadius = 20
            imageViewCell.layer.shadowColor = UIColor.blue.cgColor
        }
    }
    
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] (data, _, error) in
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.imageViewCell.image = image
            }
        }
        
        task.resume()
    }
}
