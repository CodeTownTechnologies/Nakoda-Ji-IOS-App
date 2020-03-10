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
//        configureMenu()
        getGalleryList()
    }
    
    func configureMenu() {
        let arrMenu = [["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"nakodaji1.jpg",
                        "title":"Images",
                        "type":"volunteers"],
                       ["icon":"splash.jpg",
                        "title":"Images",
                        "type":"gallery"],
                       ["icon":"splash.jpg",
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

// MARK:
// MARK: - Web services
extension GalleryVC {
    
    fileprivate func getGalleryList(){
        
        APIRequest.shared.getGalleryList(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [[String : Any]]{
                self.collView.arrDataSource = arrData
            }else{
                self.collView.arrDataSource = []
            }
        }) { (error) in
            self.collView.arrDataSource = []
        }
    }
    
    fileprivate func getGalleryImages(_ info : [String : Any]) {
        
        APIRequest.shared.getGalleryImaage(param: ["id":info.valueForString(key: "id")], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [[String : Any]], !arrData.isEmpty{
                
                if let imagePreviewVC = CMain_SB.instantiateViewController(withIdentifier:"ImagePreviewVC") as? ImagePreviewVC {
                    imagePreviewVC.arrImage = arrData
                   imagePreviewVC.modalPresentationStyle = .fullScreen
                    self.present(imagePreviewVC, animated: false, completion: nil)
                }
            }else{
                self.showAlertView("Data not found", completion: nil)
            }
            
        }) { (error) in
            
        }
    }
}

extension GalleryVC : GalleryCollViewDelegate{
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info dict: [String : Any]) {
        
        self.getGalleryImages(dict)
    }
}
