//
//  MonthYearTxtField.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

public protocol MonthYearTxtFieldDelegate : class {
    
    func didSelectTrip(_ textField: UITextField, didSelectTrip trip: Trip?)
}

class MonthYearTxtField: UITextField {

    var tripDelegate: MonthYearTxtFieldDelegate?
    var dataSource : [Trip] = [] {
        didSet{
            let arrDropDown = dataSource.compactMap({$0.title})
            self.text = arrDropDown.first
            self.setPickerData(arrPickerData: arrDropDown, selectedPickerDataHandler: { (selection, row, component) in
                self.tripDelegate?.didSelectTrip(self, didSelectTrip: self.dataSource[row])
            }, defaultPlaceholder: arrDropDown.first)
            self.tripDelegate?.didSelectTrip(self, didSelectTrip: dataSource.first)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configuration()
    }
    
    fileprivate func configuration() {
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = CRGB(r: 225, g: 225, b: 225).cgColor
        self.addRightImage(strImgName: "down", padding: 8, imageContentMode: .Left)
        self.addLeftImage(strImgName: nil, padding: 16, imageContentMode: .Center)
    }
}

