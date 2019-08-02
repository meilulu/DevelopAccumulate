//
//  LoadingView.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/3/5.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {

    var indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        return indicatorView
    }()
    
    var indicatorLabel: UILabel = {
        let label = UILabel()
        label.text = "正在加载，请稍候..."
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 249/255.0, green: 249/255.0, blue: 249/255.0, alpha: 1)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(indicatorView)
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        indicatorView.startAnimating()
        
        self.addSubview(indicatorLabel)
        indicatorLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(indicatorView)
            make.top.equalTo(indicatorView.snp.bottom).offset(5)
        }
    }
}

extension UIView {
    struct LoadingViewConstants {
        static let Tag = 10086
    }
    
    public func showLoadingView() {
        if self.viewWithTag(LoadingViewConstants.Tag) != nil {
            //loadingView已经存在，不要重复添加
            print("loadingView已经存在，不要重复添加")
            return
        }
        
        let loadingView = LoadingView(frame: self.frame)
        loadingView.tag = LoadingViewConstants.Tag
        self.addSubview(loadingView)
        
        loadingView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            loadingView.alpha = 1
        }
    }
    
    public func hideLoadingView() {
        if let loadingView = self.viewWithTag(LoadingViewConstants.Tag) {
            UIView.animate(withDuration: 0.5, animations: {
                loadingView.alpha = 0
            }, completion: { (result) in
                loadingView.removeFromSuperview()
            })
        }
    }
}
