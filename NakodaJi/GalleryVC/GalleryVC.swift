//
//  GalleryVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class GalleryVC: ParentVC {
    
    @IBOutlet weak var  collView: GalleryCollView!{
        didSet{
            collView.galleryDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Gallery"
        configureMenu()
    }
    
    func configureMenu() {
        let arrMenu = [["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.png",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"]]
        
        collView.arrDataSource = arrMenu
        collView.reloadData()
        
    }
}

extension GalleryVC : GalleryCollViewDelegate{
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info dict: [String : Any]) {
        
    }
}
