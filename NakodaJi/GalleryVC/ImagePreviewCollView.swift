//
//  ImagePreviewCollView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 08/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class ImagePreviewCollView: UICollectionView {
    @IBOutlet weak var lblIndex : UILabel!
    @IBOutlet weak var lblDetails : UILabel!
    
    var arrImages : [[String:Any]] = [] {
        didSet {
            
            if !arrImages.isEmpty {
                lblIndex.text = "\(1) of \(arrImages.count)"
                lblDetails.text = arrImages[0].valueForString(key: "title")
            }
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
    }
}

extension ImagePreviewCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CScreenWidth, height: CScreenWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagePreviewCollCell", for: indexPath) as? ImagePreviewCollCell {
            cell.configure(arrImages[indexPath.row], index: indexPath.item)
            return cell
        }
        return UICollectionViewCell()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        lblIndex.text = "\(currentPage + 1) of \(arrImages.count)"
        lblDetails.text = arrImages[currentPage].valueForString(key: "title")
    }
}


class ImagePreviewCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data:Any, index:Int) {
        if let `data` = data as? [String : Any] {
//            imgView.image = UIImage(named: (index % 2 == 0) ? "nakodaji1.jpg" : "splash.jpg")
//            imgView.kf_setImage(data.valueForString(key: "file"))
            if !data.valueForString(key: "file").isEmpty {
                imgView.kf_setImageWithURL(data.valueForString(key: "file"))
            }else {
                imgView.kf_setImageWithURL(data.valueForString(key: "image"))
            }
            
//            imgView.image = UIImage(named: data["icon"] as? String ?? "")
        }
    }
}
