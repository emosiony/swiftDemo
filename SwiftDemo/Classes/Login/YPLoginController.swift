//
//  YPLoginController.swift
//  SwiftDemo
//
//  Created by Jtg_yao on 2019/5/20.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit

class YPLoginController: UIViewController {
    
    @IBOutlet weak var logoIcon: UIImageView!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "登录"
        
        loginButton.layer.cornerRadius  = 6.0
        loginButton.layer.masksToBounds = true
        
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.setTitle("注册", for: UIControl.State.normal)
        button.setTitleColor(UIColor.black, for: UIControl.State.normal)
        button.frame = CGRect.init(x: 0, y: 0, width: 35, height: 30)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(registerClick), for: UIControl.Event.touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    @objc private func registerClick() {
        print("注册")
    }
    
    @IBAction func loginClick(_ sender: UIButton) {
        
        print("登录")
        YPUserManager.sharedInstance.isLogin = true
        YPUserManager.sharedInstance.setRootController()
    }
}
