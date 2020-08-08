//
//  YPRandomMusicController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit
import AVFoundation

class YPRandomMusicController: UIViewController {

    
    var audioPlayer = AVAudioPlayer()
    let gradientLayer = CAGradientLayer()
    
    var timer: Timer?
    var playURL: URL?
    
    var totalTimer: Float = 0.0

    lazy var progressHUD: UIProgressView = {
        
        let progress = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progress.backgroundColor = HEXColor(h: 0x666666)
        progress.progressTintColor = HEXColor(h: 0x123456)
        progress.layer.cornerRadius = 2.0
        progress.clipsToBounds = true
        return progress
    }()
    
    lazy var currentTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white;
        label.text = "00:00"
        return label
    }()
    
    lazy var totalTimerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white;
        label.text = "00:00"
        return label
    }()
    
    var backgroundColor: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)! {
        
        didSet {
            
            let color1 = UIColor(red: backgroundColor.blue,
                                 green: backgroundColor.green,
                                 blue: 0,
                                 alpha: backgroundColor.alpha).cgColor
            let color2 = UIColor(red: backgroundColor.red,
                                 green: backgroundColor.green,
                                 blue: backgroundColor.blue,
                                 alpha: backgroundColor.alpha).cgColor
            gradientLayer.colors = [color1, color2]
        }
    }
    
    lazy var playButton: UIButton = {
    
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage.init(named: "music play"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(playClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "第8天练习"
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        self.view.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        
        //graditent color
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        self.view.layer.addSublayer(gradientLayer)
        
        self.view.addSubview(self.playButton)
        
        self.view.addSubview(self.currentTimerLabel)
        self.view.addSubview(self.progressHUD)
        self.view.addSubview(self.totalTimerLabel)
        
        self.playButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        self.currentTimerLabel.snp_makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(self.playButton.snp_bottom).offset(35)
            make.height.equalTo(15);
        }
        
        self.totalTimerLabel.snp_makeConstraints { (make) in
            make.right.equalTo(-30)
            make.top.equalTo(self.currentTimerLabel.snp_top)
            make.height.equalTo(15);
        }
        
        self.progressHUD.snp_makeConstraints { (make) in
            make.left.equalTo(self.currentTimerLabel.snp_right).offset(10)
            make.centerY.equalTo(self.currentTimerLabel)
            make.right.equalTo(self.totalTimerLabel.snp_left).offset(-10)
            make.height.equalTo(4)
        }
        
        playURL = URL(fileURLWithPath: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        let audioAsset = AVURLAsset(url: playURL!, options: nil)
        let audioDuration = audioAsset.duration
        totalTimer = Float(CMTimeGetSeconds(audioDuration))
        
        self.setTimerString(label: self.totalTimerLabel, time: Int(totalTimer))
    }
    
    @objc func playClick() {
        
        if self.audioPlayer.isPlaying {
            self.audioPlayer.stop()
            timer?.invalidate()
            timer = nil
            self.currentTimerLabel.text = "00:00"
            self.progressHUD.progress   = 0.0
            return
        }
        
        do {
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
            try audioPlayer = AVAudioPlayer(contentsOf: playURL!)
            audioPlayer.delegate = self

            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let error {
            print(error)
            return
        }
        
        if (timer == nil) {
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(randomColor), userInfo: nil, repeats: true)
        }
    }
    
    @objc func randomColor() {
        
        let redValue = CGFloat(drand48())
        let blueValue =  CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        
        backgroundColor = (redValue, blueValue, greenValue, 1)
        
        DispatchQueue.main.async {
            print("\(self.audioPlayer.currentTime) \n\(self.totalTimer)")
            
            let progress = Float(self.audioPlayer.currentTime) / self.totalTimer
            self.progressHUD.progress = progress
            
            self.setTimerString(label: self.currentTimerLabel, time: Int(self.audioPlayer.currentTime))
        }
    }
    
    func setTimerString(label: UILabel, time: Int) {
        
        let hour   = Int(time / (60*60))
        let minute = Int(time % (60*60) / 60)
        let second = Int(time % 60)
        
        let hourStr   = hour > 0 ? String(format: "%02d:", hour) : ""
        let minuteStr = String(format: "%02d:", minute)
        let secondStr = String(format: "%02d", second)

        label.text = String(format: "%@%@%@", hourStr, minuteStr, secondStr)
    }

    deinit {
        if (self.timer != nil) {
            timer?.invalidate()
            timer = nil
        }
        if self.audioPlayer.isPlaying {
            self.audioPlayer.stop()
        }
    }

}

extension YPRandomMusicController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if (self.timer != nil) {
            self.timer?.invalidate()
            self.timer = nil
        }
        print(error as Any)
    }
}