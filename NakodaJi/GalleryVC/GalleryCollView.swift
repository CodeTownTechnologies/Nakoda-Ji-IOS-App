//
//  GalleryCollView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

public protocol GalleryCollViewDelegate : class {
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info dict:[String : Any])
}

class GalleryCollView: UICollectionView {
        
    var galleryDelegate : GalleryCollViewDelegate?
    var isHideNoDataFound : Bool = true
    var arrDataSource :[[String : Any]] = []{
        didSet {
            isHideNoDataFound = false
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        
    }
}

extension GalleryCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDataSource.isEmpty ? 1 : arrDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = CScreenWidth - 48
        if arrDataSource.isEmpty {
          return CGSize(width: width, height: width)
        }
        
        return CGSize(width: width/2, height: width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if arrDataSource.isEmpty  {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDataFoundCell", for: indexPath) as? UICollectionViewCell {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollCell", for: indexPath) as? GalleryCollCell {
            cell.configure(arrDataSource[indexPath.item], index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if arrDataSource.isEmpty  {
            return
        }
        galleryDelegate?.collView(collectionView, didSelectItemAt: indexPath, info: arrDataSource[indexPath.item])
        
    }
}


class GalleryCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(_ data:Any, index:Int) {
        
        if let `data` = data as? [String : Any] {
            
//            imgView.image = UIImage(named: data["icon"] as? String ?? "")
//            imgView.image = UIImage(named: (index % 2 == 0) ? "nakodaji1.jpg" : "splash.jpg")
            lblTitle.text = data.valueForString(key: "title")
            imgView.kf_setImageWithURL(data.valueForString(key: "image"))          
        }
    }
}

