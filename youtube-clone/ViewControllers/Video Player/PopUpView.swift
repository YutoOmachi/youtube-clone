//
//  PopUpView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit



class PopUpView: UIView {

    let videoViewController = VideoViewController()
    let descriptionTextView = DescriptionTextView()
    let miniStackView = MiniStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(miniStackView)
        self.addSubview(videoViewController.view)
        self.addSubview(descriptionTextView)
        self.backgroundColor = UIColor.themeColor.withAlphaComponent(0.95)
    }
    
    func updateInitialConstraints() {
        Helper.removeConstraints(for: [videoViewController.view, descriptionTextView, miniStackView])
        videoViewController.setIntialConstraints()
        descriptionTextView.setIntialConstraints()
        miniStackView.setIntialConstraints()
    }
    
    func updateMiddleConstraints(height: CGFloat, ratio: CGFloat) {
        Helper.removeConstraints(for: [videoViewController.view, descriptionTextView, miniStackView])
        videoViewController.setMiddleConstraint(height: height, ratio: ratio)
        descriptionTextView.setMiddleConstraint(height: height, ratio: ratio)
        miniStackView.setMiddleConstraint()
    }
    
    func updateMiniConstraints(height: CGFloat, ratio: CGFloat) {
        Helper.removeConstraints(for: [videoViewController.view, descriptionTextView, miniStackView])
        videoViewController.setMiniConstraint(height: height, ratio: ratio)
        descriptionTextView.setMiniConstraint()
        miniStackView.setMiniConstraint(height: height, ratio: ratio)
    }

}

