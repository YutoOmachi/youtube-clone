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
        
        setUpNavigationBarItems()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
         return .lightContent
     }

    override func viewDidLayoutSubviews() {
        if let VC = firstViewController.popUpVC {
            if VC.view.frame.size.height == 0 {
                self.tabBar.frame = self.tabBar.frame
                return
            }

            self.tabBar.frame = CGRect(x: 0, y: Helper.ScreenSize.height*(0.9 + (firstViewController.popUpVC!.view.frame.size.height/Helper.ScreenSize.height - 0.07)/6), width: self.tabBar.frame.width, height: Helper.ScreenSize.height*0.1)
        }
    }

    
    private func setUpNavigationBarItems() {
                
        let airPlayButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(systemName: "airplayvideo"), for: .normal)
            return button
        }()
        
        let uploadButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(systemName: "video"), for: .normal)
            return button
        }()
        
        let searchButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            return button
        }()
        
        let userButton: UIButton = {
            let button = UIButton()
            button.tintColor = .white
            button.setImage(UIImage(systemName: "person.circle"), for: .normal)
            return button
        }()
        
        let logoImageView: UIImageView = {
            let view = UIImageView(image: UIImage(named: "youtube_logo_dark.png"))
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleToFill
            view.tintColor = .white
            return view
        }()
        
        let buttonStackView = UIStackView()
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(airPlayButton)
        buttonStackView.addArrangedSubview(uploadButton)
        buttonStackView.addArrangedSubview(searchButton)
        buttonStackView.addArrangedSubview(userButton)
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalToConstant: Helper.ScreenSize.height*0.05),
            buttonStackView.widthAnchor.constraint(equalToConstant: Helper.ScreenSize.width*0.45),
            logoImageView.heightAnchor.constraint(equalToConstant: Helper.ScreenSize.height*0.025),
            logoImageView.widthAnchor.constraint(equalToConstant: Helper.ScreenSize.width*0.25)
        ])

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonStackView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: logoImageView)
    }
    
    private func setUp(){
        
    }
}



