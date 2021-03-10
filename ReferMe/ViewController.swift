//
//  ViewController.swift
//  ReferMe
//
//  Created by Keval on 31/01/21.
//  Copyright © 2021 StalwartItSolution. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var kgTableViewVC : KGTableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    private func setupTableView() {
        
        let titles = ["Pharmacy", "Fashion", "Mobiles and Tablets","Books","Movie Tickets","Baby Products","Groceries","Home Furnishings","Jewelry"]
        
        var arrItems = [[String : Any]?]()
        titles.forEach { (title) in
            var dictData = [String : Any]()
            dictData["name"] = title
            arrItems.append(dictData)
        }
            
        kgTableViewVC = KGTableView(withArray: arrItems, backgroundColor: UIColor(red: 22/255, green: 45/255, blue: 59/255, alpha: 1.0), key: "name")
        
        kgTableViewVC!.didTouchTheKGView = {
            UIView.animate(withDuration: 0.2, animations: {
                self.kgTableViewVC!.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }) { (comp) in
                if comp == true {
                    self.kgTableViewVC!.removeFromSuperview()
                    self.view.layoutIfNeeded()
                }
            }
        }
        kgTableViewVC!.didSelectKGTableViewRow = {(objToupleData) in
            print(objToupleData.0)
            let objDict = objToupleData.0
            if let name = objDict["name"] as? String {
                let index = arrItems.firstIndex(where: { ( $0!["name"] as? String == name) } )
                print(index as Any)
            }
            
        }
        kgTableViewVC!.frame = CGRect(x: 0, y: self.view.frame.size.height, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(kgTableViewVC!)
        
    }
    
    @objc func showTableView() {
        UIView.animate(withDuration: 0.2) {
            self.kgTableViewVC!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func btnClicked(_ sender : UIButton) {
        self.setupTableView()
        self.perform(#selector(ViewController.showTableView), with: nil, afterDelay: 0.2)
    }
}

