//
//  GenericView.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 28/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    //MARK:-
    //MARK:- Override
    
    override func awakeFromNib(){
        super.awakeFromNib()
        self.initialize()
        
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        self.initialize()
    }
    
    //MARK:-
    //MARK:- Initialize
    
    fileprivate  func initialize() {
        
        self.layer.shadowColor = CRGBA(r: 0, g: 0, b: 0, a: 0.3).cgColor
        
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 5
        self.layer.cornerRadius = 10
        
        if self.tag == 100 {
            self.layer.borderWidth = 1
            self.layer.borderColor = CRGB(r: 225, g: 225, b: 225).cgColor
            self.layer.cornerRadius = 5
        }
    }
}
