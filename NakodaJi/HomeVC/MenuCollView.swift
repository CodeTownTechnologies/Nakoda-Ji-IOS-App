//
//  MenuCollView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

public protocol MenuCollViewDelegate : class {
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info dict:[String : Any])
}

class MenuCollView: UICollectionView {
    
    @IBOutlet weak var cHeight : NSLayoutConstraint!
    var menuDelegate : MenuCollViewDelegate?
    
    var arrMenu :[[String : Any]] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        reloadData()
    }
    
    override func reloadData() {
        super.reloadData()
        self.performBatchUpdates(nil) { (complition) in
            self.cHeight.constant = self.contentSize.height
        }
    }
}

extension MenuCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrMenu.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (CScreenWidth - 48)/2
        return CGSize(width: width, height: width * 1.2727272727)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollCell", for: indexPath) as? MenuCollCell {
            cell.configure(arrMenu[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        menuDelegate?.collView(collectionView, didSelectItemAt: indexPath, info: arrMenu[indexPath.item])
        
    }
}


class MenuCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data:Any) {
        
        if let `data` = data as? [String : Any] {
            lblTitle.text = data["title"] as? String
            imgView.image = UIImage(named: data["icon"] as? String ?? "")
        }   
    }
}

