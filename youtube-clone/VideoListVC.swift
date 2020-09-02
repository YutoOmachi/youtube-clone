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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "VideoCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        cell.textLabel?.text = videos[indexPath.row].title
        return cell
    }
    
    
}
