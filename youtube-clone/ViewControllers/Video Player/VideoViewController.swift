//
//  VideoView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import AVKit

// Add Controller to the view controller?

class VideoViewController: AVPlayerViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.view.translatesAutoresizingMaskIntoConstraints = false
        let videoURL = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8")
        let player = AVPlayer(url: videoURL!)
        self.player = player
        player.play()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(1)
    }
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.view.superview!.topAnchor),
            self.view.leftAnchor.constraint(equalTo: self.view.superview!.leftAnchor),
            self.view.heightAnchor.constraint(equalTo: self.view.superview!.heightAnchor, multiplier: 0.4),
            self.view.widthAnchor.constraint(equalTo: self.view.superview!.widthAnchor, multiplier: 1),
        ])
    }
    
    func setMiddleConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.view.superview!.topAnchor),
            self.view.leftAnchor.constraint(equalTo: self.view.superview!.leftAnchor),
            self.view.heightAnchor.constraint(equalTo: self.view.superview!.heightAnchor, multiplier: (1-ratio)),
            self.view.widthAnchor.constraint(equalTo: self.view.superview!.widthAnchor, multiplier: 1)
        ])
    }
    
    

    func setMiniConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.view.topAnchor.constraint(equalTo: self.view.superview!.topAnchor),
            self.view.leftAnchor.constraint(equalTo: self.view.superview!.leftAnchor),
            self.view.heightAnchor.constraint(equalTo: self.view.superview!.heightAnchor, multiplier: 1),
            self.view.widthAnchor.constraint(equalTo: self.view.superview!.widthAnchor, multiplier: ratio)
        ])
        
    }
    
}
