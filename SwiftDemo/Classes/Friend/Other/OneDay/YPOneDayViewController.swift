//
//  YPOneDayViewController.swift
//  SwiftDemo
//
//  Created by mac on 2020/7/31.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPOneDayViewController: UIViewController {
    
    // 事件显示
    lazy var timeLabel: UILabel = {
        
        let label = UILabel()
        label.text            = "0.0";
        label.textColor       = UIColor.white
        label.backgroundColor = UIColor.black
        label.textAlignment   = NSTextAlignment.center
        label.font            = UIFont.systemFont(ofSize: 44)
        return label
    }()
    
    // 播放按钮
    lazy var playButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.blue
        button.setTitle("play", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(palyClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    // 暂停按钮
    lazy var pauseButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.green
        button.setTitle("pause", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        button.addTarget(self, action: #selector(pauseClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    var timer: Timer = Timer()
    var isPlaying: Bool = false
    
    var number : Float = 0.0 {
        willSet {
            timeLabel.text = String.init(format: "%.1f", newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第一天"
        setupSubView()
    }
    
    func setupSubView() {
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "reset", style: UIBarButtonItem.Style.plain, target: self, action: #selector(resetClick))
        
        self.view.addSubview(self.timeLabel)
        self.view.addSubview(self.playButton)
        self.view.addSubview(self.pauseButton)

        self.timeLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.view).offset(UIApplication.shared.statusBarFrame.origin.y + 44)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        self.playButton.snp_makeConstraints { (make) in
            make.top.equalTo(self.timeLabel.snp_bottom)
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        self.pauseButton.snp_makeConstraints { (make) in
            make.top.bottom.equalTo(self.playButton)
            make.left.equalTo(self.playButton.snp_right)
            make.right.equalToSuperview()
        }
    }

    @objc func resetClick() {
        
        if isPlaying {
            timer.invalidate()
        }
        number = 0.0
        isPlaying = false
    }
    
    @objc func palyClick() {
        
        if isPlaying {
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
        isPlaying = true;
    }
    
    @objc func pauseClick() {
        
        if isPlaying {
            timer.invalidate()
        }
        
        isPlaying = false
    }
    
    @objc func updateTimer() {
        
        number += 0.1
    }
    
    deinit {
        resetClick()
    }
}
