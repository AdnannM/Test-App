//
//  APICaller.swift
//  Test-App
//
//  Created by Adnann Muratovic on 26.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation


protocol APIModelDelegate {
    func fetchNews(_ news: [Article])
}

class APICaller {
    
    static let shared = APICaller()
    
    private init() {}
    
    struct Constant {
        static let storieURL = URL(string: "https://newsapi.org/v2/top-headlines?country=US&apiKey=\(NewsApiKey.apiKey)")
        static let querieStringURL = "https://newsapi.org/v2/everything?sortBy=polularity&apiKey=\(NewsApiKey.apiKey)&q="
    }
    
    
   public func getTopStories(completion: @escaping([Article]) -> Void) {
    
        guard let url = Constant.storieURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsArticles.self, from: data)
                    completion(result.articles)
                    print("Articles: \(result.articles.count)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Search With Query
    
    public func search(with query: String, completion: @escaping([Article]) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let urlString = Constant.querieStringURL + query
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
            }
                
            else if let data = data {
                do {
                    let result = try JSONDecoder().decode(NewsArticles.self, from: data)
                    completion(result.articles)
                    print("Articles: \(result.articles.count)")
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
