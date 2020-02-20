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
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "News"
        getNewsList()
        tblView.addRefreshControl(self, action: #selector(refresh))
    }
    
    @objc func refresh() {
       getNewsList()
    }
}

// MARK:
// MARK: - Web services
extension NewsVC {
    
    fileprivate func getNewsList(){
        
        APIRequest.shared.getNewsList(param: [:], successCompletion: { (response) in
            self.tblView.refreshControl?.endRefreshing()
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [[String : Any]]{
                self.tblView.arrNotification = arrData
            }else{
                self.tblView.arrNotification = []
            }
        }) { (error) in
            self.tblView.refreshControl?.endRefreshing()
            self.tblView.arrNotification = []
        }
    }
}

extension UITableView {
    
    func addRefreshControl(_ target: Any?, action: Selector){
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(target, action: action, for: .valueChanged)
        self.refreshControl = refreshControl
    }
}
