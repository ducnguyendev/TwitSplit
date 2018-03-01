//
//  BaseViewController.swift
//  TwitSplit
//
//  Created by Duc Nguyen on 3/1/18.
//  Copyright © 2018 Duc Nguyen. All rights reserved.
//

import UIKit
class BaseViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initReactive()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViewModel() {
        
    }
    
    func initReactive(){
    }
    
    
}

