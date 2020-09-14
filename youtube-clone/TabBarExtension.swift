//
//  TabBarExtension.swift
//  youtube-clone
//
//  Created by 小町悠登 on 10/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = UIApplication.shared.statusBarFrame 
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
    

}

