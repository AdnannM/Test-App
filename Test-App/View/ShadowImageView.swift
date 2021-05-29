//
//  ShadowImageView.swift
//  Test-App
//
//  Created by Adnann Muratovic on 07.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

final class ShadowImageView: UIView {

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        v.layer.cornerRadius = 20
        v.clipsToBounds = true
        return v
    }()
    
    // Hosting View For Image View (- Shadow)
    
    private lazy var baseView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOffset = CGSize(width: 5, height: 5)
        v.layer.shadowOpacity = 0.7
        v.layer.shadowRadius = 20
        return v
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(baseView)
        baseView.addSubview(imageView)
        setupConstraint()
    }
    
    func setupConstraint() {
        [baseView, imageView].forEach {(v) in
            NSLayoutConstraint.activate([
                v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                v.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
                v.topAnchor.constraint(equalTo: topAnchor, constant: 16),
                v.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
            ])
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Draw ShowPath
        baseView.layer.shadowPath = UIBezierPath(roundedRect: baseView.bounds, cornerRadius: 10).cgPath
        baseView.layer.shouldRasterize = true
        baseView.layer.rasterizationScale = UIScreen.main.scale
    }
}
