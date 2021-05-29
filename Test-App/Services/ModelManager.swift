//
//  ModelManager.swift
//  Test-App
//
//  Created by Adnann Muratovic on 22.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import Foundation

protocol ModelDelegate {
    func videoFetch(_ video: [Video])
}

class ModelManager {
    
    var delegate: ModelDelegate?
    
    func getVideos() {
        
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil && data == nil {
                return
            }
            
            do {
             
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                
                let response = try decoder.decode(Response.self, from: data!)
                
                if response.items != nil {
                    DispatchQueue.main.async {
                        self.delegate?.videoFetch(response.items!)
                    }
                }
            }
            catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
