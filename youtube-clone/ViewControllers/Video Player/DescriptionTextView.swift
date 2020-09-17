//
//  DescriptionTextView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

class DescriptionTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isEditable = false
        self.backgroundColor = UIColor.themeColor.withAlphaComponent(1)
        self.textColor = .white
        self.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 10, right: 20)

    }
    
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1, constant: -Helper.SafeScreenSize.width*9/16),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1),
        ])
    }
    
    func setMiddleConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: ratio),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 1)
        ])
        self.alpha = ratio*3 - 0.8
    }
    
    func setMiniConstraint() {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalToConstant: 0),
            self.widthAnchor.constraint(equalToConstant: 0)
        ])
    }
    
    func setText(video: Video) {
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        let published = df.string(from: video.published)
        self.text = """
        \(video.title)

        \(video.channelTitle)・\(published)

        (description)
        \(video.description)
        """
    }
}
