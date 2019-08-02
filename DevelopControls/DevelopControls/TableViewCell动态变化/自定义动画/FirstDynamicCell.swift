//
//  FirstDynamicCell.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/3/9.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import Spring

class FirstDynamicCell: UITableViewCell {
    
    var foregroundView: SpringView!
    var containerView:SpringView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        self.foregroundView = SpringView()
        self.foregroundView.backgroundColor = UIColor.yellow
        self.contentView.addSubview(self.foregroundView)
        self.foregroundView.snp.makeConstraints { (make) in
            make.top.left.equalTo(self.contentView).offset(10)
            make.height.equalTo(75)
            make.right.equalTo(self.contentView).offset(-10)
        }
        
        self.containerView = SpringView()
        self.containerView .backgroundColor = UIColor.blue
        self.contentView.addSubview(self.containerView )
        self.containerView .snp.makeConstraints { (make) in
            make.left.right.equalTo(foregroundView)
            make.height.equalTo(150)
            make.top.equalTo(self.contentView).offset(10)
        }
        
        self.foregroundView.alpha = 1
        self.containerView.alpha = 0
    }
    
    func unfold(_ value: Bool) {
        if value {
            self.openAnimation()
        }
        else {
            self.closeAnimation()
        }
    }
    
    
    func openAnimation() {
        self.foregroundView.alpha = 0
        
        self.contentView.layoutIfNeeded()
        let sourceFrame = self.containerView.frame
        //        self.containerView.frame = CGRect.zero
        //        SpringAnimation.spring(duration: 0.5) {
        //            self.containerView.alpha = 1
        //            self.contentView.frame = sourceFrame
        //        }
        
        self.containerView.animation = Spring.AnimationPreset.Morph.rawValue
        self.containerView.alpha = 1
        self.containerView.animateToNext {
            
            self.contentView.frame = sourceFrame
        }
    }
    
    func closeAnimation() {
        self.foregroundView.alpha = 1
        self.containerView.alpha = 0
        
        SpringAnimation.spring(duration: 0.5) {
            self.foregroundView.alpha = 1
        }
    }
}

