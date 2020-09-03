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
    
    let playerViewController = AVPlayerViewController()
    let descriptionTextView = UITextView()
    let miniStackView = UIStackView()
    var video: Video!

    var translation: CGPoint!
    var startPosition: CGPoint! //Start position for the gesture transition
    var originalHeight: CGFloat = 0.0 // Initial Height for the UIView
    var difference: CGFloat!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        view.subviews{
            (playerViewController.view)!
            descriptionTextView
            miniStackView
        }
        configureVideoPlayer()
        configureDescription()
        configureStackView()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewDidDrag(_:)))
        self.playerViewController.view.addGestureRecognizer(panGesture)
    }
    
    func configureVideoPlayer() {
        playerViewController.view.height(40%).top(0).fillHorizontally()
        let videoURL = URL(string: "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8")
        let player = AVPlayer(url: videoURL!)
        self.playerViewController.player = player
        player.play()
    }
    
    func configureDescription() {
        descriptionTextView.height(60%).bottom(0).fillHorizontally()
        descriptionTextView.backgroundColor = .white
        descriptionTextView.isEditable = false
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        let published = df.string(from: video.published)
        descriptionTextView.text = """
        \(video.title)
        
        \(video.channelTitle)・\(published)
        
        (description)
        \(video.description)
        """
    }
    
    func configureStackView() {
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = video.title
            return label
        }()
        let channelLabel: UILabel = {
            let label = UILabel()
            label.text = video.channelTitle
            return label
        }()
        let playStopButton: UIButton = {
            let button = UIButton()
            button.setTitle("p/s", for: .normal)
            button.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
            return button
        }()
        let closeButton: UIButton = {
            let button = UIButton(type: .close)
            button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
            return button
        }()
        let infoStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(channelLabel)
            stackView.distribution = .equalSpacing
            stackView.axis = .vertical
            return stackView
        }()
        miniStackView.addArrangedSubview(infoStackView)
        miniStackView.addArrangedSubview(playStopButton)
        miniStackView.addArrangedSubview(closeButton)
        miniStackView.axis = .horizontal
        miniStackView.distribution = .equalSpacing
        miniStackView.alpha = 0
        miniStackView.backgroundColor = .white
        miniStackView.size(0%)
    }
    
    @objc func stopTapped() {
        playerViewController.player?.pause()
    }
    
    @objc func closeTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func viewDidDrag(_ sender: UIPanGestureRecognizer) {

        if sender.state == .began {
            startPosition = sender.location(in: self.playerViewController.view) // the postion at which PanGestue Started
        }

        if sender.state == .began || sender.state == .changed {
            translation = sender.translation(in: self.view)
            sender.setTranslation(CGPoint(x: 0.0, y: 0.0), in: self.view)
            let endPosition = sender.location(in: self.view) // the posiion at which PanGesture Ended
            if endPosition.y < 150 {
                self.view.frame.size.height = 155
                return
            }
            else if endPosition.y > UIScreen.main.bounds.height {
                self.view.frame.size.height = UIScreen.main.bounds.height
                return
            }
            difference = endPosition.y - startPosition.y
            var newFrame = self.view.frame
            newFrame.origin.x = 0
            newFrame.origin.y = self.view.frame.origin.y + difference //Gesture Moving Upward will produce a negative value for difference
            newFrame.size.width = self.view.frame.size.width
            newFrame.size.height = self.view.frame.size.height - difference //Gesture Moving Upward will produce a negative value for difference
            
            let height = newFrame.size.height
            
            if height <= 300  {
                self.playerViewController.view.fillVertically().width((40+(height-150)/2.5)%).left(0)
                print(40+(height-150)/2.5)
                self.miniStackView.fillVertically().width((60-(height-150)/2.5)%).right(0)
                self.miniStackView.alpha = 1
                self.descriptionTextView.alpha = 0
            }
            else if height <= 500 {
                self.playerViewController.view.height(((660-height)/4)%).top(0).fillHorizontally()
                self.descriptionTextView.height((100-((660-height)/4))%).bottom(0).fillHorizontally()
                self.descriptionTextView.alpha = height/800
                self.miniStackView.alpha = 0
            }
            else {
                descriptionTextView.height(60%).bottom(0).fillHorizontally()
                playerViewController.view.height(40%).top(0).fillHorizontally()
            }
        
            self.view.frame = newFrame
        }
        
        if sender.state == .ended {
            print("gesture ended")
            let frame = self.view.frame
            if frame.size.height <= UIScreen.main.bounds.height/2 {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 150)
                    self.playerViewController.view.fillVertically().width(40%).left(0)
                    self.miniStackView.fillVertically().width(60%).right(0)
                    self.miniStackView.alpha = 1
                    self.descriptionTextView.alpha = 0
                }
            }
            else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.size = UIScreen.main.bounds.size
                    self.descriptionTextView.height(60%).bottom(0).fillHorizontally()
                    self.playerViewController.view.height(40%).top(0).fillHorizontally()
                    self.miniStackView.alpha = 0
                    self.descriptionTextView.alpha = 1
                }
            }
        }
    }

    
}
