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
    
    var arrDataSource :[[String : Any]] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        reloadData()
    }
}

extension GalleryCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrDataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CScreenWidth / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCollCell", for: indexPath) as? GalleryCollCell {
            cell.configure(arrDataSource[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        galleryDelegate?.collView(collectionView, didSelectItemAt: indexPath, info: arrDataSource[indexPath.item])
        
    }
}


class GalleryCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
        
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
    
    func configure(_ data:Any) {
        
        if let `data` = data as? [String : Any] {
            
            imgView.image = UIImage(named: data["icon"] as? String ?? "")
        }
    }
}

