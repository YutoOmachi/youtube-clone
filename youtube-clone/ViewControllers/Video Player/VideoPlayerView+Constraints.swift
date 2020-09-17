//
//  VideoPlayerView+TapGesture.swift
//  youtube-clone
//
//  Created by 小町悠登 on 15/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

extension VideoPlayerView {
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 9/16),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1),
            controlsContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            controlsContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            controlsContainerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            controlsContainerView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3),
            playPauseButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3),
            videoLengthLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            videoLengthLabel.bottomAnchor.constraint(equalTo: self.controlsContainerView.bottomAnchor, constant: -10),
            videoLengthLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2),
            videoLengthLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1),
            videoSlider.leftAnchor.constraint(equalTo: self.leftAnchor),
            videoSlider.centerYAnchor.constraint(equalTo: self.bottomAnchor),
            videoSlider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            videoSlider.heightAnchor.constraint(equalToConstant: 20)
        ])
        controlsContainerView.isUserInteractionEnabled = true
        controlsContainerView.isHidden = true
    }
    
    func setMiddleConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1-ratio),
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
        controlsContainerView.isUserInteractionEnabled = false
    }
}
