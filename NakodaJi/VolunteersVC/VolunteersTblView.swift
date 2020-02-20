//
//  VolunteersTblView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class VolunteersTblView: UITableView {
    var isHideNoDataFound : Bool = true
    var arrVolunteer : [Volunteer] = [] {
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

extension VolunteersTblView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrVolunteer.isEmpty ? 1 : arrVolunteer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if arrVolunteer.isEmpty {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataFoundCell") {
                cell.contentView.isHidden = isHideNoDataFound
                return cell
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "VolunteersTblViewCell") as? VolunteersTblViewCell {
            cell.configure(arrVolunteer[indexPath.row])
            return cell
            }
            
        }
        return UITableViewCell()
    }
}


class VolunteersTblViewCell: UITableViewCell {
    @IBOutlet weak var vwContent : UIView!
    @IBOutlet weak var imgProfile : UIImageView!
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
        //vwContent.layer.masksToBounds = true
        
        imgProfile.layer.cornerRadius = 25
        imgProfile.layer.masksToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnCallClicked(_ sender : UIButton){
        guard  let contactNo = contactNo else {
            return
        }
        self.callNumber(phoneNumber: contactNo)
    }
    
    func configure(_ passenger : Volunteer)  {
        lblName.text = passenger.fullName?.capitalized
        lblContact.text = "(M.) \(passenger.fullContact)"
        contactNo = passenger.fullContact.replacingOccurrences(of: "-", with: "")
        imgProfile.kf_setImageWithURL(passenger.image)
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



