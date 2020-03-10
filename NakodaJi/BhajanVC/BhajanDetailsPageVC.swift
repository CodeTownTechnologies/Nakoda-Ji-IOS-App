//
//  BhajanDetailsPageVC.swift
//  NakodaJi
//
//  Created by ishwar lal janwa on 08/02/20.
//  Copyright © 2020 MindIdeology. All rights reserved.
//

import UIKit

class BhajanDetailsPageVC: ParentPageVC {
    
    private(set) lazy var arrOrderVC: [UIViewController] = []
    var details : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialize()
    }
    
    
    fileprivate func initialize(){
        self.title = "Bhajan"
        dataSource = self
//        details = details?.replacingOccurrences(of: "\r", with: "")
        
//        guard let arrString = details?.components(separatedBy: "\n\n") else {
//            return
//        }
        
        guard let details = details else {
            return
        }
//        guard let arrString = details?.components(withMaxLength: 600) else {
//            return
//        }
        
        self.arrOrderVC = [details].map({self.newBhajanDetailsVC($0)})
        
        if let firstViewController = arrOrderVC.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                animated: true,
                completion: nil)
        }
    }
    
    private func newBhajanDetailsVC(_ details: String?) -> UIViewController {
        
        let bhajanDetailsVC = CMain_SB.instantiateViewController(withIdentifier:"BhajanDetailsVC") as! BhajanDetailsVC
        bhajanDetailsVC.details = details
        return bhajanDetailsVC
    }
}

// MARK: UIPageViewControllerDataSource

extension BhajanDetailsPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let vcIndex = arrOrderVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        return arrOrderVC[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = arrOrderVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = vcIndex + 1
               
        guard nextIndex < arrOrderVC.count else {
            return nil
        }
        
        return arrOrderVC[nextIndex]
    }
    
    
    
}
