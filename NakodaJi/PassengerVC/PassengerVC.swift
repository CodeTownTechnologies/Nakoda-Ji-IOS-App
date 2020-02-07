//
//  PassengerVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 07/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class PassengerVC: ParentVC {
    
    @IBOutlet weak var tblView : PassengerTblView!
    
    var trip : Trip?
    var bus : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Passenger Details"
        getPassengerList()
    }
    
}


// MARK:
// MARK: - Web services
extension PassengerVC {
    
    fileprivate func getPassengerList(){
        
        let param : [String : Any] = ["trip_id":trip?.id ?? "",
                                      "user_id":appDelegate?.loginUser?.id ?? "",
                                      "bus_number":bus ?? ""]
        APIRequest.shared.getPassengerList(param: param, successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [Any]{
                self.tblView.arrPassener = arrData.map({Passenger(object: $0)})
            }else{
                self.tblView.arrPassener = []
            }
        }) { (error) in
            
        }
    }
}
