//
//  ViewController.swift
//  MusicReleases
//
//  Created by Kirankumar Bollem on 2/3/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import UIKit

enum CellIdentifiers: String {
    case MusicTableViewCellIdentifier = "musicTableViewCellIdentifier"
}

enum NibNames: String {
    case MusicTableViewCell = "MusicTableViewCell"
}

class ViewController: UIViewController {
    
    @IBOutlet weak var musicReleasesTableView: UITableView!
    var musicObjectsArray: [Music] = []
    var filteredmusicObjectsArray: [Music] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.prepareView()
        self.getLatestMusicReleases()
    }
    
    /// Prepare view method handles all the basic setup needed while loading this view
    func prepareView() {
        self.musicReleasesTableView.register(UINib.init(nibName: NibNames.MusicTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: CellIdentifiers.MusicTableViewCellIdentifier.rawValue)
    }
    
    /// Fetches music data from server and reloads the table view using the music model objects data
    func getLatestMusicReleases() {
        DispatchQueue.global(qos: .background).async {
            MRHTTPSessionManager.getLatestMusicReleasesFor([:], { (response, data) in
                self.musicObjectsArray = data as? [Music] ?? []
                if self.musicObjectsArray.count > 0 {
                    DispatchQueue.main.async {
                        self.musicReleasesTableView.reloadData()
                    }
                }
            }) { (respose, error) in
                print("Error", error ?? "")
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 //Based on the art work image height
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.musicObjectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let musicTableViewCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MusicTableViewCellIdentifier.rawValue, for: indexPath) as? MusicTableViewCell
        musicTableViewCell?.music = self.musicObjectsArray[indexPath.item]
        musicTableViewCell?.updateCellAt(indexPath: indexPath)
        return musicTableViewCell ?? MusicTableViewCell()
    }
}
