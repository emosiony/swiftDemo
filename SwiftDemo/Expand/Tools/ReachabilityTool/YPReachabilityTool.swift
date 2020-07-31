//
//  YPReachabilityManager.swift
//  SwiftDemo
//
//  Created by 姚敦鹏 on 2019/6/1.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit
import Reachability


let frontNetStatus = "frontNetStatus"


class YPReachabilityTool: NSObject {
    
    let reachability = try! Reachability()
    
    /// 是否有网络
    var hasNet : Bool = false
    
    /// 网络状态
    var netStatus : Reachability.Connection = Reachability.Connection.unavailable
    
    /// 是否展示 提示 在 Windows 头部提示
    var showTipOnWindow = false
    
    let tipView : UIView =  {
        
        let topHeight = UIApplication.shared.statusBarFrame.size.height
        let view: UIView = UIView(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: topHeight))
        view.backgroundColor = UIColor.init(red: 243/255.0, green: 243/255.0, blue: 243/255.0, alpha: 1)
        view.isHidden = true
        return view
    }()
    
    
    let tipLabel : UILabel = {
        
        let label  = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor     = UIColor.init(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1)
        label.text          = "请检查您的网络情况"
        
        return label
    }()
    
    
    
    static var sharedInstance : YPReachabilityTool {
        struct Static {
            static let instance : YPReachabilityTool = YPReachabilityTool ()
        }
        return Static.instance
    }
    
    
    /// 开始监听网络
    ///
    /// - Parameter showTip: showTip description
    func startNetNotifier(showTipInWindow: Bool) {
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
        showTipOnWindow = showTipInWindow
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            netStatus = Reachability.Connection.wifi
            hasNet    = true
        case .cellular:
            print("Reachable via Cellular")
            netStatus = Reachability.Connection.cellular
            hasNet    = true
        case .none:
            print("Network not reachable")
            netStatus = Reachability.Connection.unavailable
            hasNet    = false
        case .unavailable:
            print("Network not unavailable")
            netStatus = Reachability.Connection.unavailable
            hasNet    = false
        }
        
        if showTipOnWindow {
            
            showNetChangeOnWindow()
        }
    }
    
    func showNetChangeOnWindow() {
        
        let userDefault = UserDefaults.standard
        let netStste = userDefault.value(forKey: frontNetStatus)
        var frontStatus : Bool = false
        
        if netStste != nil {
            frontStatus = netStste as! Bool
        }
        
        if frontStatus != hasNet  { // 网络 状态不同
            if hasNet == false { // 由有网络 --> 没网络
                
                if self.tipLabel.superview == nil {
                    self.tipView.addSubview(self.tipLabel)
                    self.tipLabel.snp.makeConstraints { (make) in
                        make.edges.equalTo(UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 15))
                    }
                }
                if self.tipView.superview == nil {
                    let appDelegate = AppDelegate.shareAppdelete()
                    appDelegate.window?.addSubview(self.tipView)
                }
                
                if self.tipView.isHidden {
                    
                    UIView.animate(withDuration: 0.25) {
                        self.tipView.isHidden = false
                    }
                    
                    perform(#selector(hiddenTipView), with: nil, afterDelay: 5.0)
                }
            }
        }
        
        userDefault.set(hasNet, forKey: frontNetStatus)
    }
    
    @objc func hiddenTipView() {
        UIView.animate(withDuration: 0.25) {
            self.tipView.isHidden = true
        }
    }
    
    func stopNetNotifer() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}
