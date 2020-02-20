//
//  BhajanTblView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class BhajanTblView: UITableView {
    
    var isHideNoDataFound : Bool = true
    var arrBhajan : [[String : Any]] = [] {
        didSet {
            isHideNoDataFound = false
            self.reloadData()
        }
    }
    var arrAllBhajan : [[String : Any]] = [] {
        didSet {
            self.arrBhajan = arrAllBhajan
        }
    }

    @IBOutlet weak var searchBar : UISearchBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        self.searchBar.delegate = self
    }
}

extension BhajanTblView :UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.arrBhajan = self.arrAllBhajan.filter({$0.valueForString(key: "title").lowercased().contains(searchText.lowercased())})
        
        if searchText.isEmpty {
            self.arrBhajan = self.arrAllBhajan
        }
    }
}
extension BhajanTblView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBhajan.isEmpty ? 1 : arrBhajan.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrBhajan.isEmpty {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFoundCell") {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "BhajanTblViewCell") as? BhajanTblViewCell {
                cell.lblTitle.text = arrBhajan[indexPath.row].valueForString(key: "title")
                return cell
            }
        }                
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrBhajan.isEmpty {
            return
        }
            
        if let bhajanDetailsPageVC = CMain_SB.instantiateViewController(withIdentifier:"BhajanDetailsPageVC") as? BhajanDetailsPageVC {
            bhajanDetailsPageVC.details = arrBhajan[indexPath.row].valueForString(key: "description")
            CTopMostViewController?.navigationController?.pushViewController(bhajanDetailsPageVC, animated: true)
        }
    }
}


class BhajanTblViewCell: UITableViewCell {
    @IBOutlet weak var vwContent : UIView!
    @IBOutlet weak var lblTitle : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwContent.layer.cornerRadius = 4
        vwContent.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

