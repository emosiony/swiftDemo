//
//  FiveDayModel.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class FiveDayModel {
    
    // MARK: - Public API
    var title = ""
    var description = ""
    var numberOfMembers = 0
    var numberOfPosts   = 0
    var featuredImage: UIImage!
    
    
    init(title: String, description: String, featuredImage: UIImage) {
        
        self.title         = title
        self.description   = description
        self.featuredImage = featuredImage
        numberOfMembers = 1
        numberOfPosts   = 1
    }
    
    
    // MARK: - Private
    static func createFiveModels() -> [FiveDayModel] {
        
        return [
            FiveDayModel(title: "Hello there, i miss u.", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hello")!),
            FiveDayModel(title: "🐳🐳🐳🐳🐳", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "dudu")!),
            FiveDayModel(title: "Training like this, #bodyline", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "bodyline")!),
            FiveDayModel(title: "I'm hungry, indeed.", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "wave")!),
            FiveDayModel(title: "Dark Varder, #emoji", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "darkvarder")!),
            FiveDayModel(title: "I have no idea, bitch", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "hhhhh")!),
        ]
    }
}
