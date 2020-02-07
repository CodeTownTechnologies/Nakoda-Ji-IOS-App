//
//  BookingVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 28/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class BookingVC: ParentVC {
    
    @IBOutlet weak var  collView: BookingCollView!{
        didSet{
            collView.bookingDelegate = self
        }
    }
    
    @IBOutlet weak var txtDropDown : MonthYearTxtField!{
        didSet{
            txtDropDown.tripDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Booking Details"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "logout"), style: .plain, target: self, action: #selector(btnLogOutClicked))
        getTripList()
    }
    
    
    // MARK:-
       // MARK:- Action Event
    
    @objc fileprivate func btnLogOutClicked(_ sender : UIBarButtonItem) {
        
        self.presentAlertViewWithTwoButtons(alertTitle: "", alertMessage: CMessageLogout, btnOneTitle: CBtnNo, btnOneTapped: { (action) in
            
        }, btnTwoTitle: CBtnYes) { [weak self] (action) in
            
            appDelegate?.loginUser = nil
            CUserDefaults.removeObject(forKey: UserDefaultLoginUserData)
            CUserDefaults.synchronize()
            self?.navigationController?.popViewController(animated: true)
        }
    }
}

extension BookingVC : BookingCollViewDelegate{
    
    func collView(_ collView: UICollectionView, didSelectItemAt indexPath: IndexPath, info data: Any?) {
        
        if let passengerVC = CMain_SB.instantiateViewController(withIdentifier:"PassengerVC") as? PassengerVC {
            passengerVC.bus = data as? String
            passengerVC.trip = self.collView.tripDataSource
            self.navigationController?.pushViewController(passengerVC, animated: true)
        }
    }
    
}

extension BookingVC : MonthYearTxtFieldDelegate {
    
    func didSelectTrip(_ textField: UITextField, didSelectTrip trip: Trip?) {
        self.collView.tripDataSource = trip
    }

}

// MARK:
// MARK: - Web services
extension BookingVC {
    
    fileprivate func getTripList(){
        
        APIRequest.shared.getTripList(param: ["user_id":appDelegate?.loginUser?.id ?? ""], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [Any]{
                self.txtDropDown.dataSource = arrData.map({Trip(object: $0)})
            }
        }) { (error) in
            
        }
    }
}
