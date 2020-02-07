//
//  NewsTblView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 28/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class NewsTblView: UITableView {
    var isHideNoDataFound : Bool = true
    var arrNotification : [[String : Any]] = [] {
        didSet {
            isHideNoDataFound = false
            self.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self        
    }
}

extension NewsTblView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNotification.isEmpty ? 1 : arrNotification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrNotification.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFoundCell") {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTblViewCell") as? NewsTblViewCell {
            
            return cell
        }
        return UITableViewCell()
    }
}


class NewsTblViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
