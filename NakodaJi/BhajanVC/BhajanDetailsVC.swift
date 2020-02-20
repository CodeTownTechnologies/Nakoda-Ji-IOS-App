//
//  BhajanDetailsVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 08/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class BhajanDetailsVC: UIViewController {

    @IBOutlet weak var txtView : UITextView!
    var details : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        txtView.text = details
    }    
}
