//
//  NewsTableViewCell.swift
//  Test-App
//
//  Created by Adnann Muratovic on 26.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

// MARK: - Configure Cell with viewModel
class NewsTableViewCellViewModel {
    
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String , imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
}

// MARK: - Set Custom Cell
class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    // MARK: - Labels(title - subtile) and ImagesView
    private let titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 0
        title.font = .systemFont(ofSize: 22, weight: .semibold)
        return title
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitle = UILabel()
        subtitle.numberOfLines = 0
        subtitle.font = .systemFont(ofSize: 16, weight: .light)
        return subtitle
    }()
    
    private let newsImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.contentMode = .scaleAspectFill
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        image.layer.cornerRadius = 20
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(newsImageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    
    // MARK: - Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.frame = CGRect(x: 10,
                                  y: 0,
                                  width: contentView.frame.size.width - 170,
                                  height: contentView.frame.size.height / 2)
        
        subtitleLabel.frame = CGRect(x: 10,
                                     y: 70,
                                     width: contentView.frame.size.width - 170,
                                     height: 70)
        
        newsImageView.frame = CGRect(x: contentView.frame.size.width - 150,
                                     y: 8,
                                     width: 140,
                                     height: 130
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // MARK: - Nill all Properties
        textLabel?.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
    }
    
    // MARK: - Configure Cell
    public func configure(with viewModel: NewsTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        
        
        // MARK: - Configure image
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        }
            // MARK: - Fetch Image / Dowinload
        else if let url = viewModel.imageURL  {
            
            URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
                guard let data = data, error == nil else {
                    return
                }
                // Cache image
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
}
