//
//  YPPullRefreshController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPPullRefreshController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var index = 0
    let cellIdentifer = "NewCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    
    lazy var tableView: UITableView = {
        
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.tableHeaderView = UIView(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 0.01))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0.01))
        tableView.separatorInset  = UIEdgeInsets.zero
        tableView.layoutMargins   = UIEdgeInsets.zero
        tableView.separatorStyle  = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight       = UITableView.automaticDimension
        
        tableView.estimatedRowHeight  = 44.0
        tableView.sectionHeaderHeight = 10
        tableView.sectionFooterHeight = 0.001
        
        tableView.separatorColor  = UIColor(hex: "#F3F3F3")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifer)

        return tableView
    }()
    
    let headerRefresh = UIRefreshControl()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.headerRefresh
            
            self.headerRefresh.addTarget(self, action: #selector(didRoadEmojiData), for: UIControl.Event.valueChanged)
            
            self.headerRefresh.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.headerRefresh.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
            self.headerRefresh.tintColor = UIColor.white
        }
        emojiData = favoriteEmoji

        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifer)! as UITableViewCell
        cell.textLabel!.text = self.emojiData[indexPath.row]
        cell.textLabel!.textAlignment = NSTextAlignment.center
        cell.textLabel!.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    //RoadEmoji
    
    @objc func didRoadEmojiData() {
        
        DispatchQueue.main.asyncAfter(deadline:DispatchTime.now() + 3 ) {
            self.emojiData = [self.newFavoriteEmoji,self.favoriteEmoji][self.index]
            self.tableView.reloadData()
            self.headerRefresh.endRefreshing()
            self.index = (self.index + 1) % 2
        }
    }
}
