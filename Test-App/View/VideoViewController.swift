//
//  VideoViewController.swift
//  Test-App
//
//  Created by Adnann Muratovic on 22.04.21.
//  Copyright © 2021 Adnann Muratovic. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = ModelManager()
    var video = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model.getVideos()
        model.delegate = self
        
        view.backgroundColor = UIColor.lightGray
        
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // confirm that a video is selected
        
        guard tableView.indexPathForSelectedRow != nil else { return }
        
        let selectedVideo = video[tableView.indexPathForSelectedRow!.row]
        
        let detailVC = segue.destination as! DetailViewController
        
        detailVC.video = selectedVideo
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource,ModelDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return video.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: VideoTableViewCell.identifier, for: indexPath) as! VideoTableViewCell
        
        let video = self.video[indexPath.row]
        
        cell.setCell(video)
        
        return cell
        
    }
    
    func videoFetch(_ videos: [Video]) {
        self.video = videos
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
