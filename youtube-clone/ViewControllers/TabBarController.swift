//
//  TabBarController.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let firstViewController = VideoListVC()
    let secondViewController = EmptyVC()
    let thirdViewController = EmptyVC()
    let fourthViewController = EmptyVC()
    let fifthViewController = EmptyVC()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        secondViewController.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "pencil.circle"), selectedImage: UIImage(systemName: "pencil.circle.fill"))
        thirdViewController.tabBarItem = UITabBarItem(title: "Subscriptions", image: UIImage(systemName: "rectangle.stack"), selectedImage: UIImage(systemName: "rectangle.stack.fill"))
        fourthViewController.tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "bell"), selectedImage: UIImage(systemName: "bell.fill"))
        fifthViewController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "rectangle.on.rectangle"), selectedImage: UIImage(systemName: "rectangle.on.rectangle.fill"))
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController, fourthViewController, fifthViewController]
        
        viewControllers = tabBarList
        
        self.tabBar.barTintColor = UIColor.themeColor.withAlphaComponent(1)
        self.tabBar.tintColor = UIColor.white
        
        self.setStatusBar(backgroundColor: UIColor.themeColor)
    }

    override func viewDidLayoutSubviews() {
        if firstViewController.popUpVC.view.frame.size.height == 0 {
            self.tabBar.frame = self.tabBar.frame
            return
        }
        
        self.tabBar.frame = CGRect(x: 0, y: Helper.ScreenSize.height*(0.9 + (firstViewController.popUpVC.view.frame.size.height/Helper.ScreenSize.height - 0.1)/6), width: self.tabBar.frame.width, height: Helper.ScreenSize.height*0.1)
    }

}



