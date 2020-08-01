//
//  YPTwoDayController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/1.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPTwoDayController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let cellIdentifier = "cusomFont"
    
    var data = ["30 Days Swift", "这些字体特别适合打「奋斗」和「理想」",
                "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体",
                "呵呵，再见🤗 See you next Project", "微博 @Allen朝辉",
                "测试测试测试测试测试测试", "123", "Alex", "@@@@@@"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var fontIndex = 0
    lazy var changeFontButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.backgroundColor = UIColor.black
        button.setTitle("Change Font", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont(name: self.fontNames[fontIndex], size:12)
        button.addTarget(self, action: #selector(changeFont), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 60;
        return button
    }()
    lazy var fontTableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第二天练习"
        
        self.view.addSubview(self.fontTableView)
        self.view.addSubview(self.changeFontButton)
        
        self.fontTableView.snp_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.top)
            }
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.changeFontButton.snp_top)
        }
        
        self.changeFontButton.snp_makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.bottom.equalTo(self.bottomLayoutGuide.snp.bottom)
            }
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize.init(width: 120, height: 120))
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.textLabel?.text      = data[indexPath.row]
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font      = UIFont(name: self.fontNames[fontIndex], size:16)
        
        return cell
    }
    
    @objc func changeFont() {
        
        fontIndex = (fontIndex + 1) % 4
        print(fontNames[fontIndex])
        
        self.changeFontButton.titleLabel?.font = UIFont.init(name: fontNames[fontIndex], size: 14)
        fontTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
