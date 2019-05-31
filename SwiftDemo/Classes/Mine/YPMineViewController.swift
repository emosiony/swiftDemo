



//
//  YPMaineViewController.swift
//  SwiftDemo
//
//  Created by 姚敦鹏 on 2019/6/1.
//  Copyright © 2019 jzg. All rights reserved.
//

import UIKit
import SnapKit



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
        
        if #available(iOS 11.0, *) {
            lazyTableView.separatorColor  = UIColor.init(named: "F3F3F3")
        } else {
            // Fallback on earlier versions
            lazyTableView.separatorColor  = UIColor.init(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 0.5)
        }
        
        return lazyTableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setSubView()
    }
    
    func setSubView()  {
        
        self.view.addSubview(tablebleView)
   
        tablebleView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tablebleView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = "llllll"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
