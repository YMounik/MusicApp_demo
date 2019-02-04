//
//  MRBusinessHelper.swift
//  MusicReleases
//
//  Created by Kirankumar Bollem on 2/4/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import Foundation

public class MRBusinessHelper: NSObject {
    
    /// Converts music data array into music model objects
    ///
    /// - Parameter data: Array of disctionaries with lates music data
    /// - Returns: Array of music models
    func getMusicObjectsFromData(data: Any) -> [Music] {
        print("Response %@", data)
        var musicObjectsArray: [Music] = []
        if let responseData = data as? [String: Any] {
            if let feed = responseData["feed"] as? [String: Any] {
                if let dataArray = feed["results"] as? [[String: Any]] {
                    for dict in dataArray {
                        if dict.isEmpty == false {
                            let music = Music.init(with: dict)
                            musicObjectsArray.append(music)
                        }
                    }
                }
            }
        }
        return musicObjectsArray;
    }
}
