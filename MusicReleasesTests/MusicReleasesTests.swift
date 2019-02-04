//
//  MusicReleasesTests.swift
//  MusicReleasesTests
//
//  Created by Kirankumar Bollem on 2/3/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import XCTest
@testable import MusicReleases

class MusicReleasesTests: XCTestCase {
    
    var mrBusinessHelper: MRBusinessHelper!
    
    override func setUp() {
        mrBusinessHelper = MRBusinessHelper()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetMusicObjectsFromData_NoData() {
        let data:[[String:Any]] = []
        let expectedResult: [Music] = [];
        let actualResult = mrBusinessHelper.getMusicObjectsFromData(data: data)
        XCTAssertEqual(expectedResult, actualResult, "expected result is not same as actual result")
    }
    
    func testGetMusicObjectsFromData_CorrectData() {
        let data:[String:Any] = ["feed" : ["results": [["artistId": "980795202",
                                                        "artistName": "Marshmello",
                                                        "artistUrl": "https://itunes.apple.com/us/artist/marshmello/980795202?app=music",
                                                        "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/41/06/9a/41069aa3-05b4-6c2f-eb50-fd937d0f313a/cover.jpg/200x200bb.png",
                                                        "copyright": "U2117 2019 Joytime Collective",
                                                        "id": "1451396035",
                                                        "kind": "album",
                                                        "name": "Marshmello Fortnite Extended Set (DJ Mix)",
                                                        "releaseDate": "2019-02-02",
                                                        "url": "https://itunes.apple.com/us/album/marshmello-fortnite-extended-set-dj-mix/1451396035?app=music"]]]]
        let music = Music()
        music.artistId = "980795202"
        music.artistName = "Marshmello"
        music.artistUrl = "https://itunes.apple.com/us/artist/marshmello/980795202?app=music"
        music.artworkUrl100 = "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/41/06/9a/41069aa3-05b4-6c2f-eb50-fd937d0f313a/cover.jpg/200x200bb.png"
        music.copyright = "U2117 2019 Joytime Collective"
        if let feed = data["feed"] as? [String: Any] {
            if let dataArray = feed["results"] as? [[String: Any]] {
                if let genresData = dataArray[0]["genres"] as? [[String: Any]] {
                    var genreObjects: [Genre] = []
                    for (index, genre) in genresData.enumerated() {
                        print("Item \(index): \(genre)")
                        let genreModel = Genre()
                        genreModel.genreId = genre["genreId"] as? String ?? ""
                        genreModel.name = genre["name"] as? String ?? ""
                        genreModel.url = genre["url"] as? String ?? ""
                        genreObjects.append(genreModel)
                    }
                    music.genres = genreObjects
                }
            }
        }
        music.musicId = "1451396035"
        music.kind = "album"
        music.name = "Marshmello Fortnite Extended Set (DJ Mix)"
        music.releaseDate = "2019-02-02"
        music.musicUrl = "https://itunes.apple.com/us/album/marshmello-fortnite-extended-set-dj-mix/1451396035?app=music"
        
        let expectedResult: [Music] = [music];
        let actualResult = mrBusinessHelper.getMusicObjectsFromData(data: data)
        let resultMatched = (expectedResult[0] == actualResult[0])
        XCTAssertTrue(resultMatched, "expected result is not same as actual result, failed to convert music data into music objects")
    }
    
    /// Passing empty music url to method (Assuming that we are getting empty data for url from server)
    func testGetMusicObjectsFromData1_IncorrectData() {
        let data:[String:Any] = ["feed" : ["results": [["artistId": "980795202",
                                                        "artistName": "Marshmello",
                                                        "artistUrl": "https://itunes.apple.com/us/artist/marshmello/980795202?app=music",
                                                        "artworkUrl100": "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/41/06/9a/41069aa3-05b4-6c2f-eb50-fd937d0f313a/cover.jpg/200x200bb.png",
                                                        "copyright": "U2117 2019 Joytime Collective",
                                                        "id": "1451396035",
                                                        "kind": "album",
                                                        "name": "Marshmello Fortnite Extended Set (DJ Mix)",
                                                        "releaseDate": "2019-02-02",
                                                        "url": ""]]]]
        let music = Music()
        music.artistId = "980795202"
        music.artistName = "Marshmello"
        music.artistUrl = "https://itunes.apple.com/us/artist/marshmello/980795202?app=music"
        music.artworkUrl100 = "https://is3-ssl.mzstatic.com/image/thumb/Music114/v4/41/06/9a/41069aa3-05b4-6c2f-eb50-fd937d0f313a/cover.jpg/200x200bb.png"
        music.copyright = "U2117 2019 Joytime Collective"
        if let feed = data["feed"] as? [String: Any] {
            if let dataArray = feed["results"] as? [[String: Any]] {
                if let genresData = dataArray[0]["genres"] as? [[String: Any]] {
                    var genreObjects: [Genre] = []
                    for (index, genre) in genresData.enumerated() {
                        print("Item \(index): \(genre)")
                        let genreModel = Genre()
                        genreModel.genreId = genre["genreId"] as? String ?? ""
                        genreModel.name = genre["name"] as? String ?? ""
                        genreModel.url = genre["url"] as? String ?? ""
                        genreObjects.append(genreModel)
                    }
                    music.genres = genreObjects
                }
            }
        }
        music.musicId = "1451396035"
        music.kind = "album"
        music.name = "Marshmello Fortnite Extended Set (DJ Mix)"
        music.releaseDate = "2019-02-02"
        music.musicUrl = "https://itunes.apple.com/us/album/marshmello-fortnite-extended-set-dj-mix/1451396035?app=music"
        
        let expectedResult: [Music] = [music];
        let actualResult = mrBusinessHelper.getMusicObjectsFromData(data: data)
        let resultMatched = (expectedResult[0] == actualResult[0])
        XCTAssertFalse(resultMatched, "expected result is not same as actual result, Missing music url in the data")
    }
    //Passing empty dictionary instead of data array
    func testGetMusicObjectsFromData2_IncorrectData() {
        let data:[String:Any] = ["feed" : ["results": [:]]]
        let expectedResult: [Music] = [];
        let actualResult = mrBusinessHelper.getMusicObjectsFromData(data: data)
        let result = (expectedResult == actualResult)
        XCTAssertTrue(result, "expected result is same as actual result, Received empty dictionary from server instead of results array")
    }
    
}
