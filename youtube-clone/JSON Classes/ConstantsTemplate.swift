//
//  ConstantsTemplate.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation

struct ConstantsTemplate {
    
    static var API_KEY = ""
//    static var PLAYLIST_ID = ""
    static var API_URL = "https://www.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&chart=mostPopular&regionCode=US&key=\(Constants.API_KEY)"
    
//    "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    
}
