//
//  Model.swift
//  youtube-clone
//
//  Created by 小町悠登 on 2/9/20.
//  Copyright © 2020 Yuto Omachi. All rights reserved.
//

import Foundation


class Model {
    
    func getVideos() {
        
        guard let url = URL(string: Constants.API_URL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil || data == nil {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let response = try decoder.decode(Response.self, from: data!)
                
                dump(response)
            }
            catch {
                
            }
            
        }.resume() 
        
        
    }
    
}
