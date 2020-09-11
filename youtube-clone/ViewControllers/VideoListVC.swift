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
    let popUpVC = PopUpVC()
    let headerView = VideoListHeaderView()
    
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
        print("selected")
        popUpVC.removeFromParent()
        popUpVC.view.removeFromSuperview()
        popUpVC.sampleTBC = self.tabBarController
        Helper.removeConstraints(for: [popUpVC.popUpView.videoViewController.view, popUpVC.popUpView.descriptionTextView, popUpVC.popUpView.miniStackView])
        popUpVC.popUpView.configureView()
        popUpVC.video = videos[indexPath.row]
        self.addChild(popUpVC)
        self.view.addSubview(popUpVC.view)
        UIView.animate(withDuration: 0.3) {
            self.popUpVC.view.frame = Helper.ScreenSize
        }
        popUpVC.popUpView.updateInitialConstraints()
        popUpVC.popUpView.layoutIfNeeded()
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = UIColor.themeColor
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Helper.ScreenSize.height*0.08
    }
    
}

extension VideoListVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = scrollView.contentOffset.y

        if !self.headerView.isHidden && y > 50 {
            UIView.animate(withDuration: 5, animations: {
                self.headerView.alpha = 0
            }) { ( success ) in
                print("Now it's hidden")
                self.headerView.isHidden = true
            }
        }
        else if  self.headerView.isHidden && y < -50 {
            UIView.animate(withDuration: 1, animations: {
                self.headerView.alpha = 1
            }) { ( success ) in
                self.headerView.isHidden = false
            }
        }
    }
}