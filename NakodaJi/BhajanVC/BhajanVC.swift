//
//  BhajanVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class BhajanVC: ParentVC {
    
    @IBOutlet weak var tblView : BhajanTblView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Bhajan"
        getBhajanList()
    }
}


// MARK:
// MARK: - Web services
extension BhajanVC {
    
    fileprivate func getBhajanList(){
        
        APIRequest.shared.getBhajanList(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [[String : Any]]{
                self.tblView.arrAllBhajan = arrData
            }else{
                self.tblView.arrAllBhajan = []
            }
        }) { (error) in
            self.tblView.arrAllBhajan = []
        }
    }
}
