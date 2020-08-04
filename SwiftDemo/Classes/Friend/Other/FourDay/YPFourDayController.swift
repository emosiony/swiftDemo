//
//  YPFourDayController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/3.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit


class YPFourDayController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator     = false
        scrollView.showsHorizontalScrollIndicator   = false
        scrollView.backgroundColor                  = UIColor.white
        scrollView.bounces                          = false
        scrollView.isPagingEnabled                  = true
        
        return scrollView
    }()

    lazy var leftView: UIImageView = {
        let imgView = UIImageView.init(image: UIImage.init(named: "left"))
        imgView.contentMode = UIView.ContentMode.scaleToFill
        return imgView
    }()
    
    lazy var cameraView: YPCameraView = {
        let cameraView = YPCameraView(frame: self.view.bounds)
        return cameraView;
    }()
    
    lazy var rightView: UIImageView = {
        let imgView = UIImageView.init(image: UIImage.init(named: "right"))
        imgView.contentMode = UIView.ContentMode.scaleToFill
        return imgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第四天练习"
        self.setupSubView()
    }
    
    func setupSubView() {
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.leftView)
        self.scrollView.addSubview(self.cameraView)
        self.scrollView.addSubview(self.rightView)
        
        self.scrollView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        
        self.leftView.snp_makeConstraints { (make) in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight - kStatusHeight - kHomeLineHeight)
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.scrollView.snp_left)
        }
        
        self.cameraView.snp_makeConstraints { (make) in
            make.left.equalTo(kScreenWidth)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight - kStatusHeight - kHomeLineHeight)
            make.top.bottom.equalToSuperview()
        }
        
        self.rightView.snp_makeConstraints { (make) in
            make.left.equalTo(self.cameraView.snp_right)
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(kScreenHeight - kStatusHeight - kHomeLineHeight)
            make.top.bottom.equalToSuperview()
            make.right.equalTo(self.scrollView.snp_right)
        }
        
        self.scrollView.setContentOffset(CGPoint.init(x: kScreenWidth, y: 0), animated: true)
        
//        self.leftView.frame = CGRect.init(x: -kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - kStatusNavBarHeight)
//        self.rightView.frame = CGRect.init(x: kScreenWidth, y: 0, width: kScreenWidth, height: kScreenHeight - kStatusNavBarHeight)
//        self.scrollView.contentSize = CGSize.init(width: kScreenWidth * 2, height: kStatusHeight - kStatusNavBarHeight)
    }
    

//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}
