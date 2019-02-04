//
//  Music.swift
//  MusicReleases
//
//  Created by Kirankumar Bollem on 2/4/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import Foundation

public class Music: NSObject {
    var artistId: String = ""
    var artistName: String = ""
    var artistUrl: String = ""
    var artworkUrl100: String = ""
    var copyright: String = ""
    var genres: [Genre] = []
    var musicId: String = ""
    var kind: String = ""
    var name: String = ""
    var releaseDate: String = ""
    var musicUrl: String = ""
    
    override init() {
        super.init()
    }
    
    
    /// Converts music data into the model
    ///
    /// - Parameter musicData: A dictionary with details of single music/song data
    init(with musicData: [String: Any]) {
        artistId = musicData["artistId"] as? String ?? ""
        artistName = musicData["artistName"] as? String ?? ""
        artistUrl = musicData["artistUrl"] as? String ?? ""
        artworkUrl100 = musicData["artworkUrl100"] as? String ?? ""
        copyright = musicData["copyright"] as? String ?? ""
        if let genresData = musicData["genres"] as? [[String: Any]] {
            var genreObjects: [Genre] = []
            for (index, genre) in genresData.enumerated() {
                print("Item \(index): \(genre)")
                let genreModel: Genre = Genre.init(with: genre)
                genreObjects.append(genreModel)
            }
            genres = genreObjects
        }
        musicId = musicData["id"] as? String ?? ""
        kind = musicData["kind"] as? String ?? ""
        name = musicData["name"] as? String ?? ""
        releaseDate = musicData["releaseDate"] as? String ?? ""
        musicUrl = musicData["url"] as? String ?? ""
    }
    
    
    /// Compares the data in two Music model objects
    ///
    /// - Parameters:
    ///   - lhs: Music model object
    ///   - rhs: Music model object
    /// - Returns: Boolean, YES if both model objects have same data, NO if both model objects have different data
    public static func == (lhs: Music, rhs: Music) -> Bool{
        return lhs.artistId == rhs.artistId &&
            lhs.artistName == rhs.artistName &&
            lhs.artistUrl == rhs.artistUrl &&
            lhs.artworkUrl100 == rhs.artworkUrl100 &&
            lhs.copyright == rhs.copyright &&
            lhs.musicId == rhs.musicId &&
            lhs.kind == rhs.kind &&
            lhs.name == rhs.name &&
            lhs.releaseDate == rhs.releaseDate &&
            lhs.musicUrl == rhs.musicUrl
    }
}

class Genre: NSObject {
    var genreId: String = ""
    var name: String = ""
    var url: String = ""
    
    override init() {
        super.init()
    }
    
    /// Converts genre data into genre model
    ///
    /// - Parameter genreData: A dictionary with genre details of single music/song
    init(with genreData: [String: Any]) {
        genreId = genreData["genreId"] as? String ?? ""
        name = genreData["name"] as? String ?? ""
        url = genreData["url"] as? String ?? ""
    }
}
