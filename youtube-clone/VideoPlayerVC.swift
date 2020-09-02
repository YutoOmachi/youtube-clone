//
//  VideoPlayerVC.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import Stevia

class VideoPlayerVC: UIViewController {
    
    let playerView = AVPlayerViewController()
    let descriptionLabel = UILabel()
    var video: Video!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        view.subviews{
            (playerView.view)!
            descriptionLabel
        }
        configureVideoPlayer()
        configureDescription()
    }
    
    func configureVideoPlayer() {
        playerView.view.height(40%).top(0).fillHorizontally()
        let videoURL = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8")
        let player = AVPlayer(url: videoURL!)
        self.playerView.player = player
        player.play()
    }
    
    func configureDescription() {
        descriptionLabel.height(60%).bottom(0).fillHorizontally()
        descriptionLabel.backgroundColor = .white
        descriptionLabel.numberOfLines = 0
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        let published = df.string(from: video.published)
        descriptionLabel.text = """
        \(video.title)
        
        \(video.channelTitle)・\(published)
        
        (description)
        \(video.description)
        """
    }

    
}
