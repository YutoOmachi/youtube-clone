//
//  MiniStackView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 8/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

protocol VideoControlDelegate {
    func playPauseTapped()
    func closeTapped()
}


class MiniStackView: UIStackView {

    var videoControlDelegate: VideoControlDelegate?
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white.withAlphaComponent(1)
        return button
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor.white.withAlphaComponent(1)
        return button
    }()
    let titleLabel: UIButton = {
        let label = UIButton()
        label.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        label.contentHorizontalAlignment = .left
        label.isUserInteractionEnabled = false
        label.titleLabel?.font = label.titleLabel?.font.withSize(12)
        label.titleLabel?.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let channelLabel: UIButton = {
        let label = UIButton()
        label.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 0)
        label.contentHorizontalAlignment = .left
        label.isUserInteractionEnabled = false
        label.titleLabel?.font = label.titleLabel?.font.withSize(12)
        label.titleLabel?.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var infoStackView: UIStackView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initInfoStackView()
        configureView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initInfoStackView() {
        infoStackView = UIStackView()
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(channelLabel)
        infoStackView.distribution = .fillEqually
        infoStackView.axis = .vertical
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addArrangedSubview(infoStackView)
        self.addArrangedSubview(playPauseButton)
        self.addArrangedSubview(closeButton)
        self.axis = .horizontal
        self.distribution = .fill
        self.alignment = .fill
        
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(playPauseTapped), for: .touchUpInside)
    }
    
    
    func setIntialConstraints() {
        NSLayoutConstraint.activate([
            self.closeButton.widthAnchor.constraint(equalTo: self.playPauseButton.widthAnchor, multiplier: 1),
            self.infoStackView.widthAnchor.constraint(equalTo: self.playPauseButton.widthAnchor, multiplier: 2),
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.leftAnchor.constraint(equalTo: self.superview!.leftAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 0),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 0)
        ])
    }
    
    func setMiddleConstraint() {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.superview!.topAnchor),
            self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 0),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 0)
        ])
    }
    
    func setMiniConstraint(height: CGFloat, ratio: CGFloat) {
        NSLayoutConstraint.activate([
            self.bottomAnchor.constraint(equalTo: self.superview!.bottomAnchor),
            self.rightAnchor.constraint(equalTo: self.superview!.rightAnchor),
            self.heightAnchor.constraint(equalTo: self.superview!.heightAnchor, multiplier: 1),
            self.widthAnchor.constraint(equalTo: self.superview!.widthAnchor, multiplier: 2/3)
        ])
    }
    

    @objc func playPauseTapped() {
        videoControlDelegate?.playPauseTapped()
    }

    @objc func closeTapped() {
        videoControlDelegate?.closeTapped()
    }
    
}
