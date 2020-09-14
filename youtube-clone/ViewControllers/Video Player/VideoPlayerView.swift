//
//  VideoPlayerView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 14/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoPlayerView: UIView {

    let controlsContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()

    
    let playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause.fill"), for: .normal)
        button.tintColor = UIColor.white.withAlphaComponent(1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        return button
    }()
    

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    @objc func playPauseTapped() {
        if player?.rate != 0 {
            player?.pause()
            self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player?.play()
            self.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black
        setUpContainerView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContainerView() {
        self.addSubview(controlsContainerView)
        controlsContainerView.addSubview(playPauseButton)
        NSLayoutConstraint.activate([
            controlsContainerView.topAnchor.constraint(equalToSystemSpacingBelow: self.topAnchor, multiplier: 1),
            controlsContainerView.leftAnchor.constraint(equalToSystemSpacingAfter: self.leftAnchor, multiplier: 1),
            controlsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            controlsContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            playPauseButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
    }
    
    func setUpPlayerView() {
        let videoURL = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8")
        player = AVPlayer(url: videoURL!)
        playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer!)
        updatePlayerLayer()
        playerLayer?.videoGravity = .resizeAspect
        layer.needsDisplayOnBoundsChange = true
        player?.play()
        print("start playing")
    }
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 0.4),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1),
        ])
        updatePlayerLayer()
    }
    
    func setMiddleConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: (1-ratio)),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1)
        ])
        updatePlayerLayer()
    }
    
    

    func setMiniConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: ratio)
        ])
        updatePlayerLayer()
    }
    
    func updatePlayerLayer() {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        playerLayer?.frame = self.frame
        CATransaction.commit()
    }
}
