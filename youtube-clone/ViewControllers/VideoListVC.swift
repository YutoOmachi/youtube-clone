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
    let tableView = UITableView(frame: .zero, style: .plain)
    let headerView = VideoListHeaderView()
    var previousScrollMoment: Date = Date()
    var previousScrollY: CGFloat = 0
    var animatingHeaderView = false
    var popUpVC: PopUpVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureModel()
        self.tabBarController?.navigationController?.hidesBarsOnSwipe = true
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
        tableView.rowHeight = Helper.ScreenSize.height*0.4
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if popUpVC?.view.frame != CGRect(x: 0, y: 0, width: 0, height: 0) {
            popUpVC?.dismiss(animated: true, completion: nil)
        }

        popUpVC = PopUpVC()
        popUpVC!.removeFromParent()
        popUpVC!.view.removeFromSuperview()
        popUpVC!.sampleTBC = self.tabBarController
        Helper.removeConstraints(for: [popUpVC!.popUpView.videoPlayerView, popUpVC!.popUpView.descriptionTextView, popUpVC!.popUpView.miniStackView])
        popUpVC!.popUpView.configureView()
        popUpVC!.video = videos[indexPath.row]
        self.navigationController?.addChild(popUpVC!)
        self.navigationController?.view.addSubview(popUpVC!.view)
        
        UIView.animate(withDuration: 0.5) {
            self.popUpVC!.view.frame = Helper.SafeScreenSize
        }
        popUpVC!.popUpView.updateInitialConstraints()
        popUpVC!.popUpView.layoutIfNeeded()
        popUpVC!.popUpView.videoPlayerView.startPlayerView()
    }

}

