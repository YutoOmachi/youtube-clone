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
        view.isHidden = true
        return view
    }()

    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white.withAlphaComponent(1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    @objc func playPauseTapped() {
        print("tapped")
        if player?.rate != 0 {
            player?.pause()
            self.playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
        }
        else {
            player?.play()
            self.playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.black
        setUpContainerView()
        setUpPlayerView()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpContainerView() {
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(playPauseButton)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPan(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    
    func setUpPlayerView() {
        let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//        https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8
        player = AVPlayer(url: videoURL!)
        playerLayer.videoGravity = .resizeAspect
        layer.needsDisplayOnBoundsChange = true
    }
    
    
    func startPlayerView() {
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        player?.play()

    }
    
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 0.4),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1),
            controlsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            controlsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            controlsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            controlsContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            playPauseButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2)
        ])
        controlsContainerView.isHidden = true
    }
    
    func setMiddleConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: (1-ratio)),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1)
        ])
    }
    
    

    func setMiniConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: ratio),
        ])

    }
    
}
