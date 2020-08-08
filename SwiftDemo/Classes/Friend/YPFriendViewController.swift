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
    
    var pushViewControllers = [
        YPOneDayViewController(),
        YPTwoDayController(),
        YPThreeDayController(collectionViewLayout: UICollectionViewFlowLayout()),
        YPFourDayController(),
        YPFiveDayController(),
        YPFindLocalController(),
        YPPullRefreshController(),
        YPRandomMusicController(),
        YPImageScollerController(),
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "三十天练习"
        
        for num in 1...30 {
            dataList.append("第 \(num) 天");
        }

        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.play, target: self, action: #selector(settingClick(sender:)))

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataList[indexPath.row] as? String
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     
        if indexPath.row >= pushViewControllers.count {
            return
        }
        
        let pushController = pushViewControllers[indexPath.row]
        self.navigationController?.pushViewController(pushController, animated: true)
    }
}
