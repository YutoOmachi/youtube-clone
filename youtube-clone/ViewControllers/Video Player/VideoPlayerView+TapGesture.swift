//
//  VideoPlayerView+TapGesture.swift
//  youtube-clone
//
//  Created by 小町悠登 on 15/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

extension VideoPlayerView {

    @objc func tapPan(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            print("tapped")
            controlsContainerView.isHidden = !controlsContainerView.isHidden
        }
    }

}
