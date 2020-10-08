//
//  ConstantsTemplate.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation

struct ConstantsTemplate {
    ///Enter your own API KEY
    static var API_KEY = ""
    static var API_URL = "https://www.googleapis.com/youtube/v3/videos?part=snippet&chart=mostPopular&regionCode=US&key=\(Constants.API_KEY)"
    
    
}
