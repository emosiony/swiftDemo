//
//  YPFiveDayController.swift
//  SwiftDemo
//
//  Created by mac on 2020/8/4.
//  Copyright © 2020 jzg. All rights reserved.
//

import UIKit

class YPFiveDayController: UIViewController, UICollectionViewDelegate {
    
    fileprivate let CellIdentifier = "YPFiveDayCell"
    
    lazy var bgImageView: UIImageView = {
        let image = UIImageView.init(image: UIImage.init(named: "blue"))
        return image
    }()
    
    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout();
        layout.minimumLineSpacing = 15.0
        layout.minimumInteritemSpacing = 15.0
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.layout)
        collectionView.register(UINib(nibName: CellIdentifier, bundle: nil), forCellWithReuseIdentifier: CellIdentifier)
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    fileprivate var models = FiveDayModel.createFiveModels()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "第五天练习"
        
        self.view.addSubview(self.bgImageView)
        self.view.addSubview(self.collectionView)
        
        self.bgImageView.snp_makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        self.collectionView.snp_makeConstraints { (make) in
            make.center.left.right.equalToSuperview()
            make.height.equalTo(450)
        }
        
        self.collectionView.reloadData()
    }
}

extension YPFiveDayController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: YPFiveDayCell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath) as! YPFiveDayCell
        
        cell.model = self.models[indexPath.item]
        
        return cell;
    }
}

extension YPFiveDayController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth - (15 * 2), height: 450)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}

extension YPFiveDayController : UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let originPoint = targetContentOffset.pointee;
        var index  = Int(originPoint.x / kScreenWidth)
        let offset = Int(originPoint.x) % Int(kScreenWidth)
        index += (offset > Int(kScreenWidth/2) ? 1 : 0)
        targetContentOffset.pointee = CGPoint(x: index * Int(kScreenWidth - 15) , y: 0)
    }
}
