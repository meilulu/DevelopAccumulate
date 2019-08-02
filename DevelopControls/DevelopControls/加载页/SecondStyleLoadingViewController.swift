//
//  SecondStyleLoadingViewController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/3/5.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import Spring

class SecondStyleLoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "点击", style: .done, target: self, action: #selector(doRightAction))
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "点击", style: .done, target: self, action: #selector(doLeftAction))
    }
    
    @objc func doRightAction() {
        self.view.showLoading()
    }
    
    @objc func doLeftAction() {
        self.view.hideLoading()
    }

}
