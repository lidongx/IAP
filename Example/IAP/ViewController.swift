//
//  ViewController.swift
//  IAP
//
//  Created by lidong@smalltreemedia.com on 08/31/2022.
//  Copyright (c) 2022 lidong@smalltreemedia.com. All rights reserved.
//

import UIKit
import IAP

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        IAP.setup()
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
//            let packages = IAP.shared.packages(for: "paywall-1qump91r")
//            if packages.count > 0{
//                print( packages[0].localizedPriceString)
//            }
//        }
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

