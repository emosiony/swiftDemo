//
//  YPUserManager.swift
//  SwiftDemo
//
//  Created by Jtg_yao on 2019/5/20.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit
import Onboard

class YPUserManager: NSObject {
    
    static let sharedInstance = YPUserManager()
    
    override init() { }
    
    init(dict: [String: AnyObject]) {
        
    }
    
    var isFirstOpen: Bool {
        
        get {
            
            let infoDict = Bundle.main.infoDictionary!
            let appVerson = infoDict["CFBundleShortVersionString"];
            let key = "\(YPFirstLaunch)_\(String(describing: appVerson))"
            return UserDefaults.standard.bool(forKey: key)
        }
        set {

            let infoDict = Bundle.main.infoDictionary!
            let appVerson = infoDict["CFBundleShortVersionString"];
            let key = "\(YPFirstLaunch)_\(String(describing: appVerson))"
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    var isLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: YPIsLogin)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: YPIsLogin)
        }
    }
    
    func setRootController() {
        if YPUserManager.sharedInstance.isFirstOpen {
            setNormalController()
        } else {
            generateStandardOnboardingVC()
        }
    }
    
    private func setNormalController() {
        
        if YPUserManager.sharedInstance.isFirstOpen == false {
            YPUserManager.sharedInstance.isFirstOpen = true
        }
        
        let appDelegate : AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
        
        if YPUserManager.sharedInstance.isLogin {
            
            let images = [UIImage(named: "tabbar_home"), UIImage(named: "tabbar_friend"),
                          UIImage(named: "tabbar_message"), UIImage(named: "tabbar_mine")]
            
            let selectimages = [UIImage(named: "tabbar_home_sel"), UIImage(named: "tabbar_friend_sel"),
                                UIImage(named: "tabbar_message_sel"), UIImage(named: "tabbar_mine_sel")]
            let titles = ["首页", "通讯录", "发现", "我的"]
            
            let nav : UINavigationController  = UINavigationController.init(rootViewController: YPMainController());
            nav.tabBarItem.title = titles[0]
            nav.tabBarItem.image = images[0]
            nav.tabBarItem.selectedImage = selectimages[0]
            
            let friend : UINavigationController  = UINavigationController.init(rootViewController: YPMainController());
            friend.tabBarItem.title = titles[1]
            friend.tabBarItem.image = images[1]
            friend.tabBarItem.selectedImage = selectimages[1]
            
            let find : UINavigationController  = UINavigationController.init(rootViewController: YPMainController());
            find.tabBarItem.title = titles[2]
            find.tabBarItem.image = images[2]
            find.tabBarItem.selectedImage = selectimages[2]
            
            
            let mine : UINavigationController  = UINavigationController.init(rootViewController: YPMineViewController());
            mine.tabBarItem.title = titles[3]
            mine.tabBarItem.image = images[3]
            mine.tabBarItem.selectedImage = selectimages[3]
            
            
            let tabbarController = UITabBarController()
            tabbarController.tabBar.barTintColor = UIColor.white
            tabbarController.tabBar.isTranslucent = false
            tabbarController.tabBar.tintColor = UIColor(red: 0.49, green: 0.67, blue: 0.93, alpha: 1)
//            tabbarController.tabBar.tintColor = UIColor(red: 0.49, green: 0.67, blue: 0.93, alpha: 1)
            tabbarController.viewControllers = [nav, friend, find, mine]
            
            appDelegate.window?.rootViewController = tabbarController
        } else {
            let navVC = UINavigationController.init(rootViewController: YPLoginController())
            appDelegate.window?.rootViewController = navVC
        }
    }
    
    /// 首次登陆
    private func generateStandardOnboardingVC() {
        
        let firstPage = OnboardingContentViewController.content(withTitle: "onePage", body: "What A Beautiful Photo", image: UIImage.init(named: "LaunchImage"), buttonText: nil) {
            print("onePage")
        }
        
        let twoPage = OnboardingContentViewController.content(withTitle: "onePage", body: "What A Beautiful Photo", image: UIImage.init(named: "LaunchImage"), buttonText: nil) {
            print("onePage")
        }
        
        let threePage = OnboardingContentViewController.content(withTitle: "onePage", body: "What A Beautiful Photo", image: UIImage.init(named: "LaunchImage"), buttonText: nil) {
            print("onePage")
        }
        
        let fourPage = OnboardingContentViewController.content(withTitle: "onePage", body: "What A Beautiful Photo", image: UIImage.init(named: "LaunchImage"), buttonText: "skip") {
            self.setNormalController()
        }
        
        let onboardVC = OnboardingViewController.onboard(withBackgroundImage: UIImage.init(named: "LaunchImage"), contents: [firstPage, twoPage, threePage, fourPage]);
        onboardVC?.shouldFadeTransitions = true
        onboardVC?.fadePageControlOnLastPage = true
        onboardVC?.allowSkipping = false
        onboardVC?.fadeSkipButtonOnLastPage  = true
        onboardVC?.skipHandler = {
            self.setNormalController()
        }
        
        let appDelegate : AppDelegate = (UIApplication.shared.delegate) as! AppDelegate
        appDelegate.window?.rootViewController = onboardVC;
    }
}
