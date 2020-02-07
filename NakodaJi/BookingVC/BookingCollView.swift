//
//  BookingCollView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 04/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit


public protocol BookingCollViewDelegate : class {
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info data:Any?)
}

class BookingCollView: UICollectionView {
        
    var bookingDelegate : BookingCollViewDelegate?
    var isHideNoDataFound : Bool = true
    var tripDataSource : Trip? {
        didSet {
            isHideNoDataFound = false
            self.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        reloadData()
    }
}

extension BookingCollView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripDataSource?.arrBuses?.count ?? 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if tripDataSource?.arrBuses?.isEmpty ?? true {
          return CGSize(width: CScreenWidth, height: CScreenWidth)
        }
        
        let width = (CScreenWidth - 48)/2
        return CGSize(width: width, height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if tripDataSource?.arrBuses?.isEmpty ?? true {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoDataFoundCell", for: indexPath) as? UICollectionViewCell {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookingCollCell", for: indexPath) as? BookingCollCell {
            cell.configure(tripDataSource?.arrBuses?[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if tripDataSource?.arrBuses?.isEmpty ?? true {
            return
        }
        bookingDelegate?.collView(collectionView, didSelectItemAt: indexPath, info: tripDataSource?.arrBuses?[indexPath.item])
        
    }
}


class BookingCollCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView : UIImageView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ data:Any?) {
        
        if let `data` = data as? String {
            lblTitle.text = "   " + `data`
            imgView.image = UIImage(named: "bus.jpg")
        }
    }
}

