//
//  YPConst.swift
//  SwiftDemo
//
//  Created by Jtg_yao on 2019/5/20.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit


/// 首次启动
let YPFirstLaunch = "firstLaunch"

/// 是否登录
let YPIsLogin = "isLogin"


// MARK : 高度
///宽
let kScreenWidth    = UIScreen.main.bounds.size.width
/// 高
let kScreenHeight   = UIScreen.main.bounds.size.height

/// 是否是 iPhone X 刘海屏系列
let isPhoneXLater   = isPhoneX
private var isPhoneX: Bool {
    get {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! > 0.0
        }
        return false
    }
}

/// 状态栏高度
let kStatusHeight = statusHeight
private var statusHeight : CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.windows.first?.safeAreaInsets.top)!
        }
        return 0.0
    }
}

/// 导航栏高度
let kStatusNavBarHeight = (kStatusHeight + 44.0)

/// 底部 HoneLine 高度
let kHomeLineHeight     = homeLineHeight
private var homeLineHeight: CGFloat {
    get {
        if #available(iOS 11.0, *) {
            return (UIApplication.shared.windows.first?.safeAreaInsets.bottom)!
        }
        return 0.0
    }
}

/// tabbar 高度
let kTabBarHeight = (kHomeLineHeight + 49)


// MARK : version
let kIOS8Later: Bool  = Double(UIDevice.version()) >= 8.0 ? true : false
let kIOS9Later: Bool  = Double(UIDevice.version()) >= 9.0 ? true : false
let kIOS11Later: Bool = Double(UIDevice.version()) >= 11.0 ? true : false
let kIOS13Later: Bool = Double(UIDevice.version()) >= 13.0 ? true : false


// MARK : device
/// iphone
let is_IPHONE = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone ? true : false
/// ipad
let is_IPAD   = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? true : false


// MARK : UIColor 
/// 颜色
func kRGBA(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}
func kRGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return kRGBA(r: r, g: g, b: b, alpha: 1.0)
}
func HEXColorA(h: Int, alpha: CGFloat) -> UIColor {
    return kRGBA(r: CGFloat(((h)>>16) & 0xFF), g: CGFloat((((h)>>8) & 0xFF)), b: CGFloat(((h) & 0xFF)), alpha: alpha)
}
func HEXColor(h: Int) -> UIColor {
    return HEXColorA(h: h, alpha: 1.0)
}





