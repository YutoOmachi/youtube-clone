//
//  Constants.swift
//  youtube-clone
//
//  Created by 小町悠登 on 1/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation

struct Constants {
    
    static var API_KEY = "AIzaSyA745vUyz3pVsvraBFIxjnoozhZxFgH8Qo"
    static var PLAYLIST_ID = "PLHoNUUfgs08fUA7kZCCLOttWBEVR6-DWJ"
    static var API_URL = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(Constants.PLAYLIST_ID)&key=\(Constants.API_KEY)"
    
}
