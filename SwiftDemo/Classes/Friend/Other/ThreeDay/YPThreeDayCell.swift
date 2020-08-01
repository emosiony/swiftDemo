//
//  YPThreeDayCell.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/1.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

struct Video {
    var image: String
    var title: String
    var source: String
}

class YPThreeDayCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var video: Video?
    
    func setVideo(video :Video) -> Void {
        
        self.video = video
        self.bgImage.image   = UIImage.init(named: video.image)
        self.titleLabel.text = video.title
        self.descLabel.text  = video.source
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
