//
//  YPBaseNavigationController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/1.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItem.Style.done, target: nil, action: nil)
        
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true;
        } else {
            viewController.hidesBottomBarWhenPushed = false;
        }
        
        super.pushViewController(viewController, animated: animated);
    }
}
