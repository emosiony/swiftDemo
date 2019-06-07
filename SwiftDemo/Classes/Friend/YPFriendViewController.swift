//
//  YPFriendViewController.swift
//  SwiftDemo
//
//  Created by 姚敦鹏 on 2019/6/1.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit

class YPFriendViewController: YPMineViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        YPReachabilityTool.sharedInstance.startNetNotifier(showTipInWindow: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的好友"
        
        dataList.append("anyOne")
        dataList.append("anyTwo")
        dataList.append("anyThree")
        dataList.append("anyFour")
        dataList.append("anyFive")
        dataList.append("anySix")

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.play, target: self, action: #selector(settingClick(sender:)))

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = self.dataList[indexPath.row] as? String
        return cell
        
    }
    
}
