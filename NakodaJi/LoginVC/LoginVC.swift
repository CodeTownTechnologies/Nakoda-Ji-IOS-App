//
//  LoginVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

public protocol LoginDelegate : class {
    
    func loginComplition(_ userInfo:[String : Any])
}

extension LoginDelegate {
    func loginComplition(_ userInfo:[String : Any])  {
        
    }
}

class LoginVC: ParentVC {
    
    @IBOutlet weak var btnLogin : UIButton!
    @IBOutlet weak var txtEmail : UITextField!
    @IBOutlet weak var txtPassword : UITextField!
    
    var delegate : LoginDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(btnDismissClicked))
        self.title = "Login"
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = CRGB(r: 225, g: 225, b: 225).cgColor
        
    }
    
    // MARK:-
    // MARK:- Action Event

    @objc fileprivate func btnDismissClicked(_ sender : UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: {
        })
    }
    
    @IBAction fileprivate func btnLoginClicked(_ sender : UIButton) {
//        txtEmail.text = "himanshug@yopmail.com"
//        txtPassword.text = "demo@nakoda"
        
        if isValidationPassed() {
            let param : [String : Any] = ["email":txtEmail.text ?? "",
                                          "password":txtPassword.text ?? ""]
            self.loginWebService(param)
        }
    }
}

// MARK:-
// MARK:- Web Services
extension LoginVC {
    
    fileprivate func loginWebService(_ param:[String : Any]) {
        
        APIRequest.shared.loginWith(param: param, successCompletion: { (response) in
            
            if let res = response as? [String  : Any] {
                
                if  let data = res[CJsonData] as? [String : Any] {
                       
                    let user = LoginUser(object: data)
                    appDelegate?.loginUser = user
                    CUserDefaults.setValue(user.dictionaryRepresentation(), forKey: UserDefaultLoginUserData)
                    CUserDefaults.synchronize()
                    self.dismiss(animated: true, completion: {
                        self.delegate?.loginComplition(data)
                    })
                    
                }
            }
            
        }) { (error) in
            
        }
    }
}


// MARK:-
// MARK:- Helper Method

extension LoginVC {
    
    fileprivate func isValidationPassed() -> Bool{
        
        guard let email = txtEmail.text, !email.isEmpty else {
            self.showAlertView(CMessageBlankEmail, completion: nil)
            return false         
        }
        
        guard email.isValidEmail else {
            self.showAlertView(CMessageValidEmail, completion: nil)
            return false
        }
        
        guard let password = txtPassword.text, !password.isEmpty else {
            self.showAlertView(CMessageBlankPassword, completion: nil)
            return false
        }
            
        
        return true
    }
}
