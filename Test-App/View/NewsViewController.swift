//
//  NewsViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 24.05.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit
import SafariServices
// MARK: - TableView
// MARK: - Custom Cell
// MARK: - Api Caller
// MARK: - Open the news stories
// MARK: - Search the news storie

class NewsViewController: UIViewController {
    
    // MARK: - Creating Table
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return table
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    
    private var articles = [Article]()
    private var viewModels = [NewsTableViewCellViewModel]()

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
        createSearchBar()
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
     private func getData() {
        APICaller.shared.getTopStories { [weak self] result in
            switch result {
            case (let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subtitle: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

// MARK: - TableView Delegate & DataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }

        cell.configure(with: viewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: - Search Bar Delegate
extension NewsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        
        
        // Call the API
        APICaller.shared.search(with: text) { [weak self] result in
            switch result {
            case (let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({
                    NewsTableViewCellViewModel(title: $0.title,
                                               subtitle: $0.description ?? "No Description",
                                               imageURL: URL(string: $0.urlToImage ?? "")
                    )
                })
                
                DispatchQueue.main.async {
                    self?.searchVC.dismiss(animated: true, completion: nil)
                    self?.tableView.reloadData()
                }
            }
        }
        
        print(text)
    }
}
