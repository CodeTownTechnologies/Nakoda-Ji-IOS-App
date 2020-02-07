//
//  NewsVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 28/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class NewsVC: ParentVC {
    
    @IBOutlet weak var tblView : NewsTblView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "News"
        tblView.arrNotification = [["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""],["":""]]
    }
}
