//
//  BhajanVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 29/01/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit
import PDFKit
import WebKit
import PKHUD

class BhajanVC: ParentVC {
    
    @IBOutlet weak var tblView : BhajanTblView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Bhajan"
//        let urlString = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"

//        getBhajanList()
        self.getBhajan()
//        if #available(iOS 11.0, *) {
//            showPDFView(urlString)
//        }else{
//            showWKWebView(urlString)
//        }
    }
    
    
    func showPDFView(_ urlString :String?){
        
        if #available(iOS 11.0, *) {
            guard let urlString = urlString,
                let url = URL(string: urlString) else {return}
            do{
                HUD.show(.systemActivity)
                let data = try Data(contentsOf: url)
                let pdfDOC = PDFDocument(data: data)
                
                let pdfView = PDFView(frame: self.view.bounds)
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                pdfView.displaysAsBook = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDOC
                pdfView.autoScales = true
                pdfView.maxScaleFactor = 4.0
                pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
                
                self.view.addSubview(pdfView)
                HUD.hide()
            }catch let err{
                print(err.localizedDescription)
            }
        }
    }
    
    func showWKWebView(_ urlString :String?)  {
        
        guard let urlString = urlString,
        let url = URL(string: urlString) else {return}
        HUD.show(.systemActivity)
        let webView = WKWebView(frame: view.bounds)
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        webView.navigationDelegate  = self
        view.addSubview(webView)
    }
}


// MARK:
// MARK: - Web services
extension BhajanVC {
    
    fileprivate func getBhajanList(){
        
        APIRequest.shared.getBhajanList(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let arrData = res[CJsonData] as? [[String : Any]]{
                self.tblView.arrAllBhajan = arrData
            }else{
                self.tblView.arrAllBhajan = []
            }
        }) { (error) in
            self.tblView.arrAllBhajan = []
        }
    }
    fileprivate func getBhajan(){
        
        APIRequest.shared.getBhajan(param: [:], successCompletion: { (response) in
            if let res = response as? [String : Any],
                let urlString = res[CJsonData] as? String {
                
//                if #available(iOS 11.0, *) {
//                    self.showPDFView(urlString)
//                }else{
                    self.showWKWebView(urlString)
//                }
                
            }else{
                 self.showAlertView("Data not found", completion: nil)
            }
        }) { (error) in
            self.showAlertView(error?.localizedDescription ?? "Something went wrong", title: "", completion: nil)
        }
    }
}

// MARK:
// MARK: - WKNavigationDelegate
extension BhajanVC : WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.hide()
    }
    
}



