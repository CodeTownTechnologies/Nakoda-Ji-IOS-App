//
//  HomeBannerCollView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class HomeBannerCollView: UICollectionView {
    @IBOutlet weak var pgControl : UIPageControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        pgControl.hidesForSinglePage = true
    }
}

extension HomeBannerCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CScreenWidth, height: CScreenWidth * 0.5628019324)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollCell", for: indexPath) as? BannerCollCell {
            cell.imgView.image = UIImage(named: "banner\(indexPath.row + 1).jpg")
            return cell
        }
        return UICollectionViewCell()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pgControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}


class BannerCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data:Any) {
        
    }
}
