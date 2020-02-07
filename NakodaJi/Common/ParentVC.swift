//
//  ParentVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 27/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class ParentVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewAppearance()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.resignKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        URLCache.shared.removeAllCachedResponses()
    }
    
    //MARK:-
    //MARK:- General Method
    
    fileprivate func setupViewAppearance() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        //....Generic Navigation Setup
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font:CFontNotoSans(size: 18, type: .Bold), NSAttributedString.Key.foregroundColor:ColorWhite_FFFFFF]
        
        
        self.navigationController?.navigationBar.barTintColor = ColorOrange
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barStyle = .default
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow_left")
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow_left")
        self.navigationItem.hidesBackButton = false
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    func resignKeyboard() {
        UIApplication.shared.sendAction(#selector(resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
