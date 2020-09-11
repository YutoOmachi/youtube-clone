//
//  VideoListHeaderView.swift
//  youtube-clone
//
//  Created by 小町悠登 on 11/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit

class VideoListHeaderView: UIView {
    
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
        view.contentMode = .scaleAspectFit
        view.tintColor = .white
        return view
    }()
    
    let buttonStackView = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStackView()
        setLayout()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStackView)
        self.addSubview(logoImageView)
        buttonStackView.addArrangedSubview(airPlayButton)
        buttonStackView.addArrangedSubview(uploadButton)
        buttonStackView.addArrangedSubview(searchButton)
        buttonStackView.addArrangedSubview(userButton)
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            buttonStackView.heightAnchor.constraint(equalTo: self.heightAnchor),
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonStackView.rightAnchor.constraint(equalTo: self.rightAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Helper.ScreenSize.height*0.02),
            logoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25)
        ])
    }
    
}
