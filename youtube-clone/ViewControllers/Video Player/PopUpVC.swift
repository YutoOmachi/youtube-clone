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

class PopUpVC: UIViewController {
    
    var popUpView: PopUpView!
    var sampleTBC: UITabBarController!
    var isFullScreen = true
    var video: Video! {
        didSet {
            self.popUpView.descriptionTextView.setText(video: video)
        }
    }
    
    override func loadView() {
        self.view = PopUpView()
        popUpView = self.view as? PopUpView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureView()
    }
    
    
    func configureView() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(dragPan(_:)))
        popUpView.videoPlayerView.addGestureRecognizer(panGesture)
        popUpView.miniStackView.videoControlDelegate = self
        popUpView.videoPlayerView.videoControlDelegate = self
    }
    
    
    var translation: CGPoint!
    var startPosition: CGPoint! //Start position for the gesture transition
    var originalHeight: CGFloat = 0.0 // Initial Height for the UIView
    var difference: CGFloat!
    
    @objc func dragPan(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            startPosition = sender.location(in: self.view) // the postion at which PanGestue Started
        }
        
        if sender.state == .began || sender.state == .changed {
            
            let endPosition = sender.location(in: self.view)
            difference = endPosition.y - startPosition.y
            
            //Making sure the view is within the bound
            let height = self.view.frame.size.height - difference
            if height < UIScreen.main.bounds.height*0.1 {
                return
            }
            else if height > Helper.SafeScreenSize.height {
                return
            }
            
            //configuring the new frame for the view
            let yPos = self.view.frame.origin.y + difference
            let width = self.view.frame.size.width
            var bottomBorder = Helper.ScreenSize.height
            let tabBarbottom = self.sampleTBC.tabBar.frame.minY
            if tabBarbottom < bottomBorder {
                bottomBorder = tabBarbottom
            }
            let newFrame = CGRect(x: 0, y: yPos, width: width, height: bottomBorder - yPos)
            self.view.frame = newFrame
            
            switch height {
            case _ where height < Helper.ScreenSize.height*0.15:
                let ratio = (height/Helper.ScreenSize.height)/0.15
                popUpView.updateMiniConstraints(height: height, ratio: ratio)
                self.view.layoutIfNeeded()
                self.sampleTBC.viewDidLayoutSubviews()
            
            case _ where height < Helper.ScreenSize.height*0.8 :
                let ratio = height/Helper.SafeScreenSize.height - 0.16
                popUpView.updateMiddleConstraints(height: height, ratio: ratio)
                self.view.layoutIfNeeded()
                self.sampleTBC.viewDidLayoutSubviews()
                         
            default:
                popUpView.updateInitialConstraints()
                self.view.layoutIfNeeded()
                self.sampleTBC.viewDidLayoutSubviews()
            }
        }
        
        if sender.state == .ended {
            let frame = self.view.frame
            var separationPoint: CGFloat
            if isFullScreen {
                separationPoint = 0.7
            }
            else {
                separationPoint = 0.3
            }
            if frame.size.height <= UIScreen.main.bounds.height*separationPoint {
                // Transform view to 1/4 of the screen (bottom)
                
                popUpView.updateMiniConstraints(height: Helper.ScreenSize.height*0.07, ratio: 1/3)
                UIView.animate(withDuration: 0.1) {
                    self.popUpView.descriptionTextView.alpha = 0
                    self.view.frame = CGRect(x: 0, y: Helper.ScreenSize.maxY*0.83, width: Helper.ScreenSize.width, height: Helper.ScreenSize.maxY*0.07)
                    self.view.layoutIfNeeded()
                    self.sampleTBC.viewDidLayoutSubviews()
                }
                isFullScreen = false
            }
            else {
                // Transform view to full screen
                popUpView.updateInitialConstraints()
                    
                UIView.animate(withDuration: 0.1) {
                    self.popUpView.descriptionTextView.alpha = 1
                    self.view.frame = Helper.SafeScreenSize
                    self.sampleTBC.viewDidLayoutSubviews()
                    self.view.layoutIfNeeded()
                }
                isFullScreen = true
            }
        }
    }
    
}


extension PopUpVC: VideoControlDelegate {
    
    func playPauseTapped() {
        if let player = self.popUpView.videoPlayerView.player {
            if player.rate != 0 {
                player.pause()
                self.popUpView.miniStackView.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                self.popUpView.videoPlayerView.playPauseButton.setImage(UIImage(named: "play.png"), for: .normal)
            }
            else {
                player.play()
                self.popUpView.miniStackView.playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                self.popUpView.videoPlayerView.playPauseButton.setImage(UIImage(named: "pause.png"), for: .normal)
            }
        }
    }
    
    func closeTapped() {
        self.willMove(toParent: nil)
        self.removeFromParent()
        self.view.removeFromSuperview()
        self.popUpView.descriptionTextView.alpha = 1
        self.popUpView.videoPlayerView.player?.pause()
        self.parent?.navigationController?.hidesBarsOnSwipe = true
        self.dismiss(animated: true, completion: nil)
    }
}

