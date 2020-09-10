//
//  CacheManager.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache(_ url: String, _ data: Data) {
        cache[url] = data
    }
    
    static func getVideoCache(_ url: String) -> Data? {
        return cache[url]
    }
    
}
