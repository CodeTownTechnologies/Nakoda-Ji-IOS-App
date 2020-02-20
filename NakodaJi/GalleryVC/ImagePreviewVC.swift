//
//  ImagePreviewVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 08/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class ImagePreviewVC: ParentVC {
    
    @IBOutlet weak var  collView: ImagePreviewCollView!
    
    var arrImage : [[String : Any]]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let images = arrImage {
            
            collView.arrImages = images
        }
//        configureMenu()
    }
    
    func configureMenu() {
        let arrMenu = [["icon":"nakodaji1.jpg",
                        "title":"Images1",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images2",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images3",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                       "title":"Images4",
                       "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images5",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images6",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                       "title":"Images7",
                       "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images8",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images9",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images10",
                        "type":"gallery"]]
        
        collView.arrImages = arrMenu
        
    }
    
    @IBAction func btnBackClicked(_ sender : UIButton){
        self.dismiss(animated: false, completion: nil)
    }
}
