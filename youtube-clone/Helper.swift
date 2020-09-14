//
//  Helper.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//


import UIKit

class Helper {
    
    static var ScreenSize = UIScreen.main.bounds
        
    
    static var SafeScreenSize = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-UIApplication.shared.statusBarFrame.height)
    
    
    static func removeConstraints(for views: [UIView]) {
        
        for view in  views {
            if let heightConstraint = view.heightConstraint {
                heightConstraint.isActive = false
            }
            if let widthConstraint = view.widthConstraint {
                widthConstraint.isActive = false
            }
            if let leftConstraint = view.leftConstraint {
                leftConstraint.isActive = false
            }
            if let rightConstraint = view.rightConstraint {
                rightConstraint.isActive = false
            }
            if let topConstraint = view.topConstraint {
                topConstraint.isActive = false
            }
            if let bottomConstraint = view.bottomConstraint {
                bottomConstraint.isActive = false
            }
        }
    }

    
}
