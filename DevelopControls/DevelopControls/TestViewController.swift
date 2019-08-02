//
//  TestViewController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/1/30.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let aLabel = UILabel()
        aLabel.text = "1112222"
        self.view.addSubview(aLabel)
        aLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(100)
        }

        let aView = QRCodePreview.init(frame: self.view.frame)
        self.view.addSubview(aView)
        

    }
}
