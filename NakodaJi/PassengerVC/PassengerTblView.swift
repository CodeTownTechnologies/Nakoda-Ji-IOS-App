//
//  PassengerTblView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 07/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class PassengerTblView: UITableView {
    var isHideNoDataFound : Bool = true
    var arrPassener : [Passenger] = [] {
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

extension PassengerTblView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrPassener.isEmpty ? 1 : arrPassener.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrPassener.isEmpty {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFoundCell") {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerTblViewCell") as? PassengerTblViewCell {
                cell.configure(arrPassener[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
}


class PassengerTblViewCell: UITableViewCell {
    @IBOutlet weak var vwContent : UIView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblContact : UILabel!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var btnCall : UIButton!
    
    var contactNo : String?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwContent.layer.borderWidth = 1
        vwContent.layer.borderColor = CRGB(r: 225, g: 225, b: 225).cgColor
        vwContent.layer.cornerRadius = 10
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(_ passenger : Passenger)  {
        lblName.text = passenger.fullName?.capitalized
        lblContact.text = "(M.) \(passenger.fullContact)"
        contactNo = passenger.fullContact.replacingOccurrences(of: "-", with: "")
    }
    
    @IBAction func btnCallClicked(_ sender : UIButton){
        guard  let contactNo = contactNo else {
            return
        }
        self.callNumber(phoneNumber: contactNo)
    }
    
    private func callNumber(phoneNumber:String) {

      if let phoneCallURL = URL(string: "tel://\(phoneNumber)") {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }
}

