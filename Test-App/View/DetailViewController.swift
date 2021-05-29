//
//  DetailViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 22.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var textView: UITextView!
    
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

     navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Clear fiels
        titleLabel.text = ""
        dateLabel.text = ""
        textView.text = ""
        
        guard video != nil else { return }
        
        let embededURL = Constants.YT_EMBED_URL + video!.videoId
        
        // load request
        let url = URL(string: embededURL)
        let request = URLRequest(url: url!)
        webView.load(request)
        
        
        // Set title date and description
        
        titleLabel.text = video!.title
        
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        dateLabel.text = df.string(from: video!.published)
        
        textView.text = video?.description
    }

}
