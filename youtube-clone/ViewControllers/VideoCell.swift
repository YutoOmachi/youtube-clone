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
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = UIColor.themeColor.withAlphaComponent(1)
        return label
    }()
    var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.backgroundColor = UIColor.themeColor.withAlphaComponent(1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.subviews{
            thumbnailImageView
            stackView
        }
        self.backgroundColor = UIColor.themeColor.withAlphaComponent(1)
        configureThumbnail()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureThumbnail() {
        thumbnailImageView.height(70%).top(0).fillHorizontally()
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.backgroundColor = UIColor.white.withAlphaComponent(1)
    }
    
    func configureStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(infoLabel)
        stackView.height(25%).bottom(0).left(2%).width(96%)
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor.themeColor.withAlphaComponent(1)
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
        
        // try high resolution thumbnail
        var url = URL(string: video.thumbnailHigh)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data!)
                
                if url?.absoluteString != video.thumbnailHigh {
                   return
                }
                
                let image = UIImage(data: data!)
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }.resume()
        
        //if high resolution thumbnail not found, try standart quality
        if self.thumbnailImageView.image == nil {
            url = URL(string: video.thumbnail)
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
    
}
