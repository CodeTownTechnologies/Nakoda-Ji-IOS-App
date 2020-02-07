//
//  HomeVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class HomeVC: ParentVC {

    @IBOutlet weak var bannerCollView : HomeBannerCollView!
    @IBOutlet weak var menuCollView : MenuCollView!{
        didSet{
            menuCollView.menuDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    fileprivate func initialize(){
        
        self.title = "Nakoda Bhairav Mandal"
        configureMenu()
    }
    
    func configureMenu() {
        let arrMenu = [["icon":"volunteers",
                        "title":"Group Volunteers",
                        "type":"volunteers"],
                       ["icon":"gallery",
                        "title":"Gallery",
                        "type":"gallery"],
                       ["icon":"music_icon",
                        "title":"Bhajan",
                        "type":"bhajan"],
                       ["icon":"news_icon",
                        "title":"News",
                        "type":"news"],
                       ["icon":"booking_icon",
                        "title":"Booking Detail",
                        "type":"booking"],
                       ["icon":"date_icon",
                        "title":"Program Detail",
                        "type":"program"]]
        
       /* let arrMenu = [["icon":"news_icon",
                        "title":"News",
                        "type":"news"],
                       ["icon":"booking_icon",
                        "title":"Booking Detail",
                        "type":"booking"]] */
        
        menuCollView.arrMenu = arrMenu
        menuCollView.reloadData()
        
    }
}

// MARK:-
// MARK:-  MenuCollViewDelegate

extension HomeVC : MenuCollViewDelegate {
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info dict: [String : Any]) {
        
        switch dict.valueForString(key:"type") {
            
        case "volunteers":
            if let volunteersVC = CMain_SB.instantiateViewController(withIdentifier:"VolunteersVC") as? VolunteersVC {
                self.navigationController?.pushViewController(volunteersVC, animated: true)
            }
            
            
        case "gallery":
            if let galleryVC = CMain_SB.instantiateViewController(withIdentifier:"GalleryVC") as? GalleryVC {
                self.navigationController?.pushViewController(galleryVC, animated: true)
            }
            
        case "bhajan":
            
            if let bhajanVC = CMain_SB.instantiateViewController(withIdentifier:"BhajanVC") as? BhajanVC {
                self.navigationController?.pushViewController(bhajanVC, animated: true)
            }
            
        case "news":
            if let newsVC = CMain_SB.instantiateViewController(withIdentifier:"NewsVC") as? NewsVC {
                self.navigationController?.pushViewController(newsVC, animated: true)
            }
            
        case "booking":
            
            if appDelegate?.loginUser != nil {
                
                if let bookingVC = CMain_SB.instantiateViewController(withIdentifier:"BookingVC") as? BookingVC {
                     self.navigationController?.pushViewController(bookingVC, animated: true)
                 }
            }else if let loginVC = CMain_SB.instantiateViewController(withIdentifier:"LoginVC") as? LoginVC {
                loginVC.delegate = self
                
                let navigation = UINavigationController(rootViewController: loginVC)
                navigation.modalPresentationStyle = .fullScreen
                self.present(navigation, animated: true, completion: nil)
            }
             
            
        case "program":
            
            if let programVC = CMain_SB.instantiateViewController(withIdentifier:"ProgramVC") as? ProgramVC {
                self.navigationController?.pushViewController(programVC, animated: true)
            }
            
        default:
            break
        }
    }
}


// MARK:-
// MARK:-  MenuCollViewDelegate

extension HomeVC : LoginDelegate {
    
    func loginComplition(_ userInfo: [String : Any]) {
        if let bookingVC = CMain_SB.instantiateViewController(withIdentifier:"BookingVC") as? BookingVC {
            self.navigationController?.pushViewController(bookingVC, animated: true)
        }
    }
}
