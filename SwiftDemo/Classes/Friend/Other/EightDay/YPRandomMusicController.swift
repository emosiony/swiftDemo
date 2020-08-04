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
        
        self.playButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc func playClick() {
        
        if self.audioPlayer.isPlaying {
            self.audioPlayer.stop()
            timer?.invalidate()
            timer = nil
            return
        }
        
        let bgMusic = URL(fileURLWithPath: Bundle.main.path(forResource: "Ecstasy", ofType: "mp3")!)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true, options: AVAudioSession.SetActiveOptions.init())
            try audioPlayer = AVAudioPlayer(contentsOf: bgMusic)
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
