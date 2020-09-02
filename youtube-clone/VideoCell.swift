//
//  VideoCell.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import UIKit
import Stevia

class VideoCell: UITableViewCell {
    
    var thumbnailImageView = UIImageView()
    var stackView = UIStackView()
    var titleLabel = UILabel()
    var infoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.subviews{
            thumbnailImageView
            stackView
        }
        configureThumbnail()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureThumbnail() {
        thumbnailImageView.height(75%).width(100%).top(0).centerHorizontally()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = .white
    }
    
    func configureStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infoLabel)
        stackView.height(25%).width(100%).bottom(0).centerHorizontally()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        titleLabel.backgroundColor = .white
        infoLabel.backgroundColor = .white
        titleLabel.numberOfLines = 0
        infoLabel.numberOfLines = 0
    }
    
    func updateData(_ video: Video) {
        titleLabel.text = video.title
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        let published = df.string(from: video.published)
        infoLabel.text = "\(video.channelTitle)・\(published)"
        
        if let cacheData = CacheManager.getVideoCache(video.thumbnail) {
            self.thumbnailImageView.image = UIImage(data: cacheData)
            return
        }
        
        guard video.thumbnail != "" else { return }
        let url = URL(string: video.thumbnail)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data!)
                
                if url?.absoluteString != video.thumbnail {
                   return
                }
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }.resume()
    }
    
}
