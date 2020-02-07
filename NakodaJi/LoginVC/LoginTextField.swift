//
//  LoginTextField.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import UIKit

class LoginTextField: UITextField {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.configuration()
    }
    
    fileprivate func configuration() {
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = CRGB(r: 225, g: 225, b: 225).cgColor
        self.addRightImage(strImgName: nil, padding: 16, imageContentMode: .Left)
        self.addLeftImage(strImgName: nil, padding: 16, imageContentMode: .Center)
    }
}
