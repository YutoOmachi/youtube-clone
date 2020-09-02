//
//  ViewController.swift
//  youtube-clone
//
//  Created by 小町悠登 on 31/8/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import Stevia

class VideoListVC: UIViewController {

    var model = Model()
    var videos = [Video]()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        configureTableView()
        configureModel()
    }
    
    func configureModel() {
        model.getVideos()
        model.delegate = self
    }
    
    func configureTableView() {
        view.subviews {
            tableView
        }
        tableView.size(100%)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: "VideoCell")
        tableView.rowHeight = 350
    }

}


extension VideoListVC: ModelDelegate {
    func videosFetched(_ videos:[Video]) {
        self.videos = videos
        tableView.reloadData()
    }
}


extension VideoListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as? VideoCell {
            let video = self.videos[indexPath.row]
            cell.updateData(video)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = VideoPlayerVC()
        VC.modalPresentationStyle = .fullScreen
        VC.modalTransitionStyle = .coverVertical
        VC.video = self.videos[indexPath.row]
        present(VC, animated: true)
    }
}
