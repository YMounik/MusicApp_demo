//
//  MusicTableViewCell.swift
//  MusicReleases
//
//  Created by Kirankumar Bollem on 2/3/19.
//  Copyright © 2019 Kirankumar Bollem. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    var music: Music!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCellAt(indexPath: IndexPath) {
        self.thumbnailImageView.imageFromURL(urlString: music.artworkUrl100)
        self.artistNameLabel.text = music.artistName
        self.songNameLabel.text = music.name
    }
}

extension UIImageView {
    public func imageFromURL(urlString: String) {
        self.image = nil
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
                if error != nil {
                    print(error ?? "")
                    return
                }
                let image = UIImage(data: data!)
                DispatchQueue.main.async(execute: { () -> Void in
                    self.image = image
                })
            }).resume()
        }
    }
}
