



//
//  YPMaineViewController.swift
//  SwiftDemo
//
//  Created by 姚敦鹏 on 2019/6/1.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit
import SnapKit
import Hue


class YPMineViewController: UIViewController,
UITableViewDelegate, UITableViewDataSource {
    
    
    lazy var tablebleView : UITableView = {
        
        let lazyTableView : UITableView = UITableView(frame: CGRect.zero, style: UITableView.Style.grouped)
        
        lazyTableView.delegate        = self
        lazyTableView.dataSource      = self
        lazyTableView.tableHeaderView = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 0.01))
        lazyTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.01))
        lazyTableView.separatorInset  = UIEdgeInsets.zero
        lazyTableView.layoutMargins   = UIEdgeInsets.zero
        lazyTableView.separatorStyle  = UITableViewCell.SeparatorStyle.singleLine
        lazyTableView.rowHeight       = UITableView.automaticDimension

        lazyTableView.estimatedRowHeight  = 44.0
        lazyTableView.sectionHeaderHeight = 10
        lazyTableView.sectionFooterHeight = 0.001
    
        lazyTableView.separatorColor  = UIColor(hex: "#F3F3F3")
        
        return lazyTableView
    }()
    
    lazy var dataList : Array = Array<Any>()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我的"
                
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.stop, target: self, action: #selector(settingClick(sender:)))
        setSubView()
    }
    
    func setSubView()  {
        
        self.view.addSubview(tablebleView)
   
        tablebleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tablebleView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc func settingClick(sender: UIBarButtonItem) {
        print(sender)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
