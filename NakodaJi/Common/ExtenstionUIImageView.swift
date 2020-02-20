//
//  ExtenstionUIImageView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 16/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - Kingfisher

extension UIImageView {
    
    func kf_setImageWithURL(_ sUrl : String?,style : UIActivityIndicatorView.Style = .white, imageOptions : KingfisherOptionsInfo = [] ,completed : ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil)  {
       
        guard let sUrl = sUrl,
            !sUrl.isEmpty,
            let url = URL(string: sUrl) else {
                return
        }
        self.backgroundColor = .white
        let resource = ImageResource(downloadURL: url, cacheKey:nil)
        
        // This would survive on even the lowest spec devices!
        self.startAnimating()
        var imageOption = imageOptions
        imageOption.append(.processor(DownsamplingImageProcessor(size: self.frame.size)))
        imageOption.append(.scaleFactor(UIScreen.main.scale))
        self.kf.indicatorType = .activity
        self.kf.setImage(with: resource,
                         options: imageOption)
        { [weak self] (result) in
            self?.backgroundColor = .clear
            guard let `self` = self else { return }
            completed?(result)
        }
    }
    
    func kf_setImage(_ sUrl : String?){
        guard let sUrl = sUrl,
            !sUrl.isEmpty,
            let url = URL(string: sUrl) else {
                return
        }        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }

}
