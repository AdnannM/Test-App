//
//  PhotoViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 05.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var colletionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searcBar: UISearchBar!
    
    var selectedImage: String?

     let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=50&client_id=sAKzB4VANnRpYQOXPgN97LJjFwetNOQp-Dk-TTD2GFc"

    var result: [Result] = []
    
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searcBar.delegate = self
        
       // colletionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        viewModel.showLoading = {
            if self.viewModel.isLoading {
                self.activityIndicator.startAnimating()
                self.colletionView.alpha = 0.0
            } else {
                self.activityIndicator.stopAnimating()
                self.colletionView.alpha = 1
            }
        }
        
        fetchPhoto()
        
       
    }
    
  
    
    func fetchPhoto() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.result = jsonResult.results
                    self?.colletionView.reloadData()
                }
            }
                
            catch {
                print(error.localizedDescription)
            }
            
            print("Got data")
        }
        task.resume()
    }
    
    func fetchPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=sAKzB4VANnRpYQOXPgN97LJjFwetNOQp-Dk-TTD2GFc"
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(ApiResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.result = jsonResult.results
                    self?.colletionView.reloadData()
                }
            }
                
            catch {
                print(error.localizedDescription)
            }
            
            print("Got data")
        }
        task.resume()
    }
    
}

// MARK: - Layout

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumn: CGFloat = 2
        
        let width =  collectionView.frame.size.width
        let xInset: CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width / numberOfColumn) - (xInset + cellSpacing), height: (width / numberOfColumn) - (xInset + cellSpacing))
    }
}

// MARK: - DataSource
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let imageURL = result[indexPath.row].urls.regular
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: imageURL)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "image") as! FullImageViewController
        vc.selecedImage = result[indexPath.row].urls.regular
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotoViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
        if let text = searchBar.text {
            result = []
            colletionView.reloadData()
            fetchPhotos(query: text)
        }
    }
}
