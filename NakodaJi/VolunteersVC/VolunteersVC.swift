//
//  VolunteersVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class VolunteersVC: ParentVC {

    @IBOutlet weak var tblView : VolunteersTblView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Group Volunteers"
        getVolunteerList()
    }

}

// MARK:
// MARK: - Web services
extension VolunteersVC {
    
    fileprivate func getVolunteerList(){
        
        APIRequest.shared.getStaffList(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [Any]{
                self.tblView.arrVolunteer = arrData.map({Volunteer(object: $0)})
            }else{
                self.tblView.arrVolunteer = []
            }
        }) { (error) in
            
        }
    }
}
