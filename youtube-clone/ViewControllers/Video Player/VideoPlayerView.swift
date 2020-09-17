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
        view.isUserInteractionEnabled = false
        view.isHidden = true
        return view
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "pause.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white.withAlphaComponent(1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    @objc func playPauseTapped() {
        if player?.rate != 0 {
            player?.pause()
            self.playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
        }
        else {
            player?.play()
            self.playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
        }
    }
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc func handleSliderChange() {
        
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(videoSlider.value) * totalSeconds
            
            let seekTime = CMTime(seconds: value, preferredTimescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                
            })
        }

    }
    
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
    
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
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
        controlsContainerView.addSubview(videoLengthLabel)
        controlsContainerView.addSubview(videoSlider)
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapPan(_:)))
        self.addGestureRecognizer(tapGesture)
    }

    
    @objc func tapPan(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            controlsContainerView.isHidden = !controlsContainerView.isHidden
        }
    }
    
    
    func setUpPlayerView() {
        let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")
//        https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8
        player = AVPlayer(url: videoURL!)
        playerLayer.videoGravity = .resizeAspectFill
        layer.needsDisplayOnBoundsChange = true
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let secondsText = Int(seconds) % 60
                let minutesText = String(format: "%02d", Int(seconds)/60)
                videoLengthLabel.text = "\(minutesText):\(secondsText)"
            }
        }
    }
    
    
    func startPlayerView() {
        if player?.status == .readyToPlay {
            
        }
        do {
           try AVAudioSession.sharedInstance().setCategory(.playback)
        } catch(let error) {
            print(error.localizedDescription)
        }
        player?.play()

    }
    
}
