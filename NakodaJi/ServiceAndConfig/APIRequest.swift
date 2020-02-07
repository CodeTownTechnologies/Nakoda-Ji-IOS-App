//
//  APIRequest.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 05/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

//MARK:-
//MARK:- API TAG

let  CAPILogin = "login"
let  CAPIGetStaffList = "get_staff_list"
let  CAPIGetTripsList = "get_trips_list"
let  CAPIGetPassengerList = "get_passenger_list"
let  CAPIUpdateDeviceToken = "update_device_token"

///... USER DETAIL
let  CAPIUserDetail =  "get_profile_data"
let  CAPISearchParkingSpace =  "search_parking_space"
///... LRF

let  CAPISendOTP = "send_otp"
let  CAPIVerifyPhoneNumber = "verify_phone_number"

let  CAPILogOut = "user_logout"
let  CAPIChangePassword = "change_password"
let  CAPIResetPassword = "reset_password"




class APIRequest {
    
    var loggingEnabled = true
    private init() {}
    
    private static var apiRequest:APIRequest = {
        let apiRequest = APIRequest()
        return apiRequest
    }()
    
    static var shared:APIRequest {
        return apiRequest
    }
    
    typealias successCompletion = (Any?) -> Void
    typealias failureCompletion   = (Error?) -> Void
    typealias progressCompletion = (Progress) -> Void
}

// MARK: -
// MARK: - APIRequest Basic Configurations.

extension APIRequest {
    
    
    fileprivate var header : HTTPHeaders {
        
        if CUserDefaults.value(forKey: UserDefaultLoginUserToken) != nil {
            // return ["Authorization" : "Bearer \((CUserDefaults.value(forKey: UserDefaultLoginUserToken)) as? String ?? "")",
            //                "Content-Type":"application/x-www-form-urlencoded"]
            
            return ["auth-token" : "\((CUserDefaults.value(forKey: UserDefaultLoginUserToken)) as? String ?? "")",
                "Content-Type":"application/x-www-form-urlencoded"]
            
        } else {
            return ["auth-token" : "",
                    "Content-Type":"application/x-www-form-urlencoded"]
        }
        
    }
    
    fileprivate static var arrSuccessStatus = [Int](200 ... 299)
    fileprivate static var arrFailureStatus = [400 , 401 , 403 , 405 , 429 , 503]
}


// MARK: -
// MARK: - loggingRequest && loggingResponse Methods.

extension APIRequest {
    
    fileprivate func loggingRequest(request:DataRequest?) -> Void {
        
        if let request = request, loggingEnabled {
            
            var body:String = ""
            var length = 0
            
            if (request.request?.httpBody != nil) {
                body = String.init(data: (request.request!.httpBody)!, encoding: String.Encoding.utf8)!
                length = request.request!.httpBody!.count
            }
            
            let printableString = "\(request.request!.httpMethod!) '\(request.request!.url!.absoluteString)': \(String(describing: request.request!.allHTTPHeaderFields)) \(body) [\(length) bytes]"
            
            print("API Request: \(printableString)")
        }
    }
    
    fileprivate func loggingResponse(response:DataResponse<Any>?) {
        
        if let response = response, loggingEnabled {
            
            if let error = response.result.error {
                print("API Response: (\(response.response?.statusCode ?? 0) [\(response.timeline.totalDuration)s] Response: \(error)")
                
            } else {
                
                print("API Response: (\(response.response?.statusCode ?? 0) [\(response.timeline.totalDuration)s] Response: \(response.result.value ?? "")")
            }
        }
    }
}

// MARK: -
// MARK: - Alamofire Various HTTP Methods && Handlation of Status Code.
extension APIRequest {
    
    fileprivate func GET(apiURL:String?,  param:[String: Any]?, successCompletion:successCompletion?,  failureCompletion:failureCompletion?) -> URLSessionTask? {
        
        guard let apiURL = apiURL else { return nil }
        
        let uRequest = SessionManager.default.request(apiURL, method: .get, parameters: param, encoding: URLEncoding.default, headers: header)
        
        self.loggingRequest(request: uRequest)
        
        uRequest.responseJSON { (response) in
            self.handleHTTPResponseStatus(response: response, successCompletion: successCompletion, failureCompletion: failureCompletion)
        }
        
        return uRequest.task
    }
    
    fileprivate  func POST(apiURL:String? , param:[String:Any]? , successCompletion:@escaping successCompletion , failureCompletion:@escaping failureCompletion) -> URLSessionTask? {
        
        guard let apiURL = apiURL else { return nil }
        
        let uRequest = SessionManager.default.request(apiURL, method: .post, parameters: param, encoding: URLEncoding.default, headers: header)
        
        self.loggingRequest(request: uRequest)
        
        uRequest.responseJSON { (response) in
            self.handleHTTPResponseStatus(response: response, successCompletion: successCompletion, failureCompletion: failureCompletion)
        }
        return uRequest.task
    }
    
    fileprivate func POST(apiURL:String?, param:[String: Any]?, multipartFormData: @escaping (MultipartFormData) -> Void, successCompletion:successCompletion? , failureCompletion:failureCompletion?, progressCompletion: progressCompletion?)   {
        
        guard let apiURL = apiURL else { return }
        
        print("API Request: \(apiURL) \(param as Any)")
        
        SessionManager.default.upload(multipartFormData: { (multipart) in
            
            multipartFormData(multipart)
            
            if let param = param {
                
                for (key, value) in param {
                    
                    multipart.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)! , withName: key)
                }
            }
        }, to: apiURL, method: .post, headers: header) { (encodingResult) in
            
            switch encodingResult {
                
            case .success(let uRequest, _, _):
                
                uRequest.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                    progressCompletion?(progress)
                })
                
                uRequest.responseJSON { (response) in
                    
                    self.handleHTTPResponseStatus(response: response, successCompletion: successCompletion, failureCompletion: failureCompletion)
                }
                
            case .failure(let encodingError):
                print(encodingError)
                failureCompletion?(encodingError)
            }
        }
    }
    
    fileprivate func Delete(apiURL:String?,  param:[String: Any]?, successBlock successCompletion:successCompletion?,   failureBlock failureCompletion:failureCompletion?) -> URLSessionTask? {
        
        guard let apiURL = apiURL else { return nil }
        
        let uRequest = SessionManager.default.request(apiURL, method: .delete, parameters: param, encoding: URLEncoding.default, headers: nil)
        
        self.loggingRequest(request: uRequest)
        
        uRequest.responseJSON { (response) in
            self.handleHTTPResponseStatus(response: response, successCompletion: successCompletion, failureCompletion: failureCompletion)
        }
        
        return uRequest.task
    }
    
    
    fileprivate  func handleHTTPResponseStatus(response:DataResponse<Any> , successCompletion: successCompletion? , failureCompletion:failureCompletion?) {
        
        loggingResponse(response: response)
        
        guard let httpResponse = response.response else {
            
            if let successCompletion = successCompletion {
                successCompletion(nil)
            }
            if let failureCompletion = failureCompletion {
                failureCompletion(response.error)
                
            }
            return
        }
        
        
        let statusCode = httpResponse.statusCode
        
        if APIRequest.arrSuccessStatus.contains(statusCode),
            response.result.error == nil,
            let successCompletion = successCompletion {
            successCompletion(response.result.value)
            
        } else if let failureCompletion = failureCompletion {
            
            if let error = response.result.error  {
                failureCompletion(error)
            }
            else {
                
                let dict = response.result.value as? [String : AnyObject]
                
                guard let message = dict?.valueForString(key: "message") else {
                    
                    let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey :"Error found but error message not found"])
                    
                    return failureCompletion(error)
                }
                
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey :message ])
                failureCompletion(error)
            }
        }
    }
}



// MARK: -
// MARK: - JSON Validation and Alerts.
extension APIRequest {
    
    func isJSONDataValid(response: Any?) -> Bool {
        
        guard let jsonResponse = response as? [String : Any] else {
            return false
        }
        
        guard let data = jsonResponse.value(forKey: CJsonData) else {
            return false
        }
        
        if let dataString = data as? String, dataString.count == 0 {
            return false
        }
        
        
        if let dataArray = data as? [Any], dataArray.count == 0 {
            return false
        }
        
        
        return self.isJSONStatusValid(response: jsonResponse)
    }
    
    func isJSONStatusValid(response: Any?) -> Bool {
        
        guard let jsonResponse = response as? [String : Any] else {
            return false
        }
        
        if  jsonResponse.valueForString(key: CReplayStatusCode) == CStatusSuccess {
            return  true
        }
        else {
            return false
        }
    }
    
    func checkAPIStatus(response: Any?, showAlert:Bool) -> Bool {
        
        guard let jsonResponse = response as? [String : Any] else {
            return false
        }
        
        let status = jsonResponse.valueForString(key: CReplayStatusCode)
        
        switch status {
            
        case CStatusSuccess:
            return true
            
        default :
            if showAlert {
                CTopMostViewController?.showAlertView(jsonResponse.valueForString(key: CReplyMessage), completion: nil)
            }
        }
        
        return false
    }
    
    func failureWithError(_ error : Error?, showAlert : Bool)  {
        
        if error != nil {
            
            
            if let error = error as NSError? {
                
                if error.code == 502 {
                    
                    if !(CTopMostViewController is UIAlertController) {
                        CTopMostViewController?.showAlertView("Session expired.\n\nPlease login again.", title: CAlertTitle, completion: { (action) in
                        })
                    }
                    
                }else if error.code == -1009 {
                    var message = error.localizedDescription
                    
                    if message.isEmpty {
                        message = "The Internet connection appears to be offline."
                    }
                    if !(CTopMostViewController is UIAlertController) {
                        CTopMostViewController?.showAlertView(message, title: CAlertTitle, completion: { (action) in
                            
                        })
                    }
                }
            } else if showAlert {
                CTopMostViewController?.showAlertView(error?.localizedDescription ?? "Something went wrong", completion: nil)
            }
        }
    }
    
}


// MARK: -
// MARK: - APIs Methods.
extension APIRequest {
    
    func getStaffList(param:[String:Any] , successCompletion:@escaping successCompletion, failureCompletion:failureCompletion?)  {
        
        //user_name
        //user_email
        //user_password
        //device_type
        //device_token
        
        var param = param
        param["methodName"] = CAPIGetStaffList
        param["device_type"] = "ios"
        
        HUD.show(.labeledRotatingImage(image: UIImage(named: "progress"), title: "", subtitle: ""))
        _ = POST(apiURL: BASEURL, param: param, successCompletion: { (response) in
            HUD.hide()
            if self.checkAPIStatus(response: response, showAlert: false) {
                successCompletion(response)
            }
        }, failureCompletion: { (error) in
            HUD.hide()
            self.failureWithError(error, showAlert: false)
            failureCompletion?(error)
        })
    }
    // MARK: -
    // MARK: - LRF
    
    
    func loginWith(param:[String:Any] , successCompletion:@escaping successCompletion, failureCompletion:failureCompletion?)  {
        
        //email
        //password
        
        var param = param
        param["methodName"] = CAPILogin
        param["device_type"] = "ios"
        
        HUD.show(.labeledRotatingImage(image: UIImage(named: "progress"), title: "", subtitle: ""))
        _ = POST(apiURL: BASEURL, param: param, successCompletion: { (response) in
            HUD.hide()
            if self.checkAPIStatus(response: response, showAlert: true) {
                successCompletion(response)
            }
        }, failureCompletion: { (error) in
            HUD.hide()
            self.failureWithError(error, showAlert: true)
            failureCompletion?(error)
        })
    }
    
    func getTripList(param:[String:Any] , successCompletion:@escaping successCompletion, failureCompletion:failureCompletion?)  {
        
        //user_id
        
        var param = param
        param["methodName"] = CAPIGetTripsList
        param["device_type"] = "ios"
        HUD.show(.labeledRotatingImage(image: UIImage(named: "progress"), title: "", subtitle: ""))
        
        _ = POST(apiURL: BASEURL, param: param, successCompletion: { (response) in
            HUD.hide()
            if self.checkAPIStatus(response: response, showAlert: true) {
                successCompletion(response)
            }
        }, failureCompletion: { (error) in
            HUD.hide()
            self.failureWithError(error, showAlert: true)
            failureCompletion?(error)
        })
    }
    
    func getPassengerList(param:[String:Any] , successCompletion:@escaping successCompletion, failureCompletion:failureCompletion?)  {
        
        //user_id
        //trip_id
        //bus_number
        
        var param = param
        param["methodName"] = CAPIGetPassengerList
        param["device_type"] = "ios"
        HUD.show(.labeledRotatingImage(image: UIImage(named: "progress"), title: "", subtitle: ""))
        _ = POST(apiURL: BASEURL, param: param, successCompletion: { (response) in
            HUD.hide()
            if self.checkAPIStatus(response: response, showAlert: true) {
                successCompletion(response)
            }
        }, failureCompletion: { (error) in
            HUD.hide()
            self.failureWithError(error, showAlert: true)
            failureCompletion?(error)
        })
    }
    
    func updateDeviceToken(param:[String:Any] , successCompletion:@escaping successCompletion, failureCompletion:failureCompletion?)  {
        
        //user_id
        //device_type
        //device_token
        
        var param = param
        param["methodName"] = CAPIUpdateDeviceToken
        param["device_type"] = "ios"
        param["device_token"] = CUserDefaults.value(forKey: UserDefaultDeviceToken)
        
        //HUD.show(.labeledRotatingImage(image: UIImage(named: "progress"), title: "", subtitle: ""))
        _ = POST(apiURL: BASEURL, param: param, successCompletion: { (response) in
            HUD.hide()
            if self.checkAPIStatus(response: response, showAlert: true) {
                successCompletion(response)
            }
        }, failureCompletion: { (error) in
            HUD.hide()
            self.failureWithError(error, showAlert: true)
            failureCompletion?(error)
        })
    }
}


//MARK:-
//MARK:- SAVE DATA
extension APIRequest {
    
    func saveLoginUserToLocal(responseObject:Any?) {
        
        if let responseObject  = responseObject as? [String : Any],
            let data = responseObject.valueForJSON(key: CJsonData) as? [String : Any] {
            
            CUserDefaults.setValue(data.valueForString(key: "auth_token"), forKey: UserDefaultLoginUserToken)
            CUserDefaults.synchronize()
        }
    }
}
