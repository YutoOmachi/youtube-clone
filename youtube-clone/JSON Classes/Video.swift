//
//  Video.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation

struct Video: Decodable {
    
    var id = ""
    var channelTitle = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var thumbnailHigh = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case channelTitle
        case id
        case title
        case description
        case published = "publishedAt"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        self.title = try snippetContainer.decode(String.self, forKey: .title)
        self.description = try snippetContainer.decode(String.self, forKey: .description)
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        self.channelTitle  = try snippetContainer.decode(String.self, forKey: .channelTitle)

        //Parse VideoID
        self.id = try container.decode(String.self, forKey: .id)
        
        // Parse thumbnail
        //        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        //        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        //        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        self.thumbnail = "https://img.youtube.com/vi/\(id)/mqdefault.jpg"
        self.thumbnailHigh = "https://img.youtube.com/vi/\(id)/maxresdefault.jpg"
    }
    
}
