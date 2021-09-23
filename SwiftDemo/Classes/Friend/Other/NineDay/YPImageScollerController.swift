//
//  YPImageScollerController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/5.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPImageScollerController: UIViewController, UIScrollViewDelegate {
    
    var imgScrollView = UIScrollView()
    var currentImage  = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第9天练习"

        let bgImageView = UIImageView.init(image: UIImage.init(named: "steve"))
        self.view.addSubview(bgImageView)
        bgImageView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        let effectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: UIBlurEffect.Style.light))
        effectView.frame = self.view.bounds
        self.view.addSubview(effectView)
        
        imgScrollView = UIScrollView.init()
        imgScrollView.bounces = false
        imgScrollView.delegate = self
        self.view.addSubview(imgScrollView);
        imgScrollView.snp_makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
            make.size.equalToSuperview()
        }
        imgScrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        currentImage = UIImageView.init(image: UIImage.init(named: "steve"))
        imgScrollView.addSubview(currentImage)
        currentImage.snp_makeConstraints { (make) in
            make.center.equalTo(imgScrollView)
        }
        
        let widthScale  = view.bounds.size.width / currentImage.bounds.width
        let heightScale = view.bounds.size.height / currentImage.bounds.height
        let minScale    = min(widthScale, heightScale)
        
        imgScrollView.minimumZoomScale = minScale
        imgScrollView.maximumZoomScale = 3.0
        imgScrollView.zoomScale        = minScale
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize) {
        
        let yOffset = max(0, (size.height - currentImage.frame.height) / 2)
        let xOffset = max(0, (size.width - currentImage.frame.width) / 2)
        
        currentImage.snp_remakeConstraints { (make) in
            make.top.equalTo(yOffset)
            make.bottom.equalTo(-yOffset)
            make.left.equalTo(xOffset)
            make.right.equalTo(-xOffset)
        }
        
        view.layoutIfNeeded()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateConstraintsForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return currentImage
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
