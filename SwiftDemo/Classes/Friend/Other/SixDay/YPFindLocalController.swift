//
//  YPFindLocalController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit
import CoreLocation

class YPFindLocalController: UIViewController {
    
    lazy var bgImageView: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named: "bg"))
        return image
    }()
    
    lazy var localView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var localLabel: UILabel = {
        let lable = UILabel()
        lable.font = UIFont.init(name: "Gaspar Regular", size: 14)
        lable.text            = "My location"
        lable.textColor       = UIColor.white
        lable.numberOfLines   = 0
        lable.textAlignment   = NSTextAlignment.center
        lable.backgroundColor = UIColor.clear
        return lable
    }()
    
    lazy var findButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setBackgroundImage(UIImage.init(named: "Find my location"), for: UIControl.State.normal)
        button.setTitle("Find my location", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.addTarget(self, action: #selector(findLocalClick), for: UIControl.Event.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    var locationManager: CLLocationManager!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第6天练习"
        self.setupSubView()
    }
    
    func setupSubView() {
    
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.localView)
        self.view.addSubview(self.findButton)
        
        self.localView.addSubview(self.localLabel)
        
        self.bgImageView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.localView.snp_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom).offset(40)
            }
            make.left.equalTo(35)
            make.right.equalTo(-35)
        }
        
        self.localLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.init(top: 10, left: 5, bottom: 10, right: 5))
        }
        
        self.findButton.snp_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom).offset(-25)
            }
            make.left.greaterThanOrEqualTo(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(78)
        }
    }
    
    @objc func findLocalClick() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
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
