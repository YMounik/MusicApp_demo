//
//  MRHTTPSessionManager.swift
//  MusicReleases
//
//  Created by Kirankumar Bollem on 2/3/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import Foundation
import UIKit

class MRHTTPSessionManager: MRNetworkManager {
    
    
    /// Get Apple latest Music releases
    ///
    /// - Parameters:
    ///   - parameters: request body of the URL
    ///   - successHandler: returns JSON response of searched query
    ///   - failureHandler: returns error response with response code
    class func getLatestMusicReleasesFor(_ parameters: [String: String], _ successHandler: @escaping networkSuccessHandler, _ failureHandler: @escaping networkFailureHandler) -> Void {
        let urlStr: NSString = "https://rss.itunes.apple.com/api/v1/us/apple-music/new-releases/all/100/explicit.json" as NSString
        if let url = URL(string: urlStr.addingPercentEscapes(using: String.Encoding.utf8.rawValue) as! String) {
            self.get(url, { (response, data) in
                if data is [String: Any] {
                    let information = data as! [String: Any]
                    if let error = information["error"] as? String {
                        let nserror = NSError(domain: "BI Domain", code: -1000, userInfo: [NSLocalizedDescriptionKey: error])
                        failureHandler(response, nserror)
                    }else {
                        let mrBusinessHelper = MRBusinessHelper()
                        let musicObjectsArray: [Music] = mrBusinessHelper.getMusicObjectsFromData(data: data)
                        successHandler(response, musicObjectsArray)
                    }
                }else {
                    print(#function)
                }
            }) { (response, error) in
                failureHandler(response, error)
            }
        }
    }
}
