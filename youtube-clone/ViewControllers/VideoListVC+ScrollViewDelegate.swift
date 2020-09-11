//
//  VideoListVC+ScrollViewDelegation.swift
//  youtube-clone
//
//  Created by 小町悠登 on 12/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import Stevia

extension VideoListVC: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        if animatingHeaderView{
            return
        }
        if  y<0 || y>scrollView.contentSize.height-Helper.ScreenSize.height {
            previousScrollMoment = Date()+0.5
            return
        }
        let d = Date()
        let elapsed = Date().timeIntervalSince(previousScrollMoment)
        let distance = (y - previousScrollY)
        let velocity = (elapsed <= 0) ? 0 : (distance / CGFloat(elapsed))
        previousScrollMoment = d
        previousScrollY = y
        
        if headerView.alpha == 1 && velocity > 500 {
            animatingHeaderView = true
            Helper.removeConstraints(for: [headerView, headerView.buttonStackView, headerView.logoImageView])
            headerView.top(-self.headerView.frame.height).fillHorizontally().height(100%)
            headerView.setLayout()
            UIView.animate(withDuration: 1, animations: {
                self.headerView.alpha = 0
                self.tableView.layoutIfNeeded()
            }) { (value:Bool) in
                self.animatingHeaderView = false
            }
        }
        else if headerView.alpha == 0 && velocity < -500 {
            animatingHeaderView = true
            Helper.removeConstraints(for: [headerView, headerView.buttonStackView, headerView.logoImageView])
            headerView.fillContainer()
            headerView.setLayout()
            UIView.animate(withDuration: 1, animations: {
                self.headerView.alpha = 1
                self.tableView.layoutIfNeeded()
            }) { (value:Bool) in
                self.animatingHeaderView = false
            }
        }
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        self.headerView.alpha = 1
        self.headerView.isHidden = false
    }
    
    
}
