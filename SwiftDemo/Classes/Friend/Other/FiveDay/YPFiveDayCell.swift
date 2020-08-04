//
//  YPFiveDayCell.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPFiveDayCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var model: FiveDayModel! {
        
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        
        self.titleLabel.text = model.title
        self.imageView.image = model.featuredImage
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.clear
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds      = true
        
        self.titleLabel.font = UIFont.init(name: "MFJinHei_Noncommercial-Regular", size: 14)
    }

}
