//
//  ProgramVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class ProgramVC: ParentVC {

    @IBOutlet weak var txtView : UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Program Detail"
        getProgramDetails()
    }
}

// MARK:
// MARK: - Web services
extension ProgramVC {
    
    fileprivate func getProgramDetails(){
        
        APIRequest.shared.getProgramDetails(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let data = res[CJsonData] as? [String : Any]{
                self.txtView.text = data.valueForString(key: "description")
                
            }else{
                self.txtView.text = "\n\n\n\n\nData not found"
                self.txtView.textAlignment = .center
            }
        }) { (error) in
            self.txtView.text = "\n\n\n\n\nData not found"
            self.txtView.textAlignment = .center
        }
    }
}
