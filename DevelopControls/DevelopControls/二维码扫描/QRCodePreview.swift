//
//  QRCodePreview.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/1/30.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

//二维码扫描视图
import UIKit

class QRCodePreview: UIView {
    var coverView: UIView = {
        let view = UIView()
        return view
    }()
    
    var scannerView = UIView()
    
    var scanLine: UIImageView = {
        let view = UIImageView(image: UIImage(named: "QRCodeScanLine"))
        return view
    }()
    
    fileprivate var timer:Timer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        let width = UIScreen.main.bounds.width

        self.addSubview(self.scanLine)
        
        let baseView = UIView()
        baseView.frame = self.frame
        baseView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        self.addSubview(baseView)

        self.scannerView = UIView(frame: CGRect.init(x: 0, y: 0, width: width * 0.7, height: width * 0.7))
        self.scannerView.center = CGPoint(x: self.center.x, y: self.center.y - 50)
        let path = UIBezierPath(rect: self.bounds)
        let rectPath = UIBezierPath(roundedRect: self.scannerView.frame, cornerRadius: 0)
        path.append(rectPath.reversing())

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        baseView.layer.mask = maskLayer
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.scannerView.frame.width, height: 50))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.text = "将二维码/条形码放入扫描框内，即自动扫描"
        baseView.addSubview(label)
        label.center = CGPoint(x: baseView.center.x, y: self.scannerView.frame.maxY + 30)
    }
    
    func startMove() {
        self.timer = Timer(timeInterval: 2, target: self, selector: #selector(moveScanLine), userInfo: nil, repeats: true)
        RunLoop.current.add(self.timer, forMode: .commonModes)
        self.timer.fire()
    }
    
    func stopMove(){
        self.timer.invalidate()
    }
    
    @objc func moveScanLine() {
        print("11111")
        self.scanLine.frame = CGRect(x: self.scannerView.frame.minX, y: self.scannerView.frame.minY, width: self.scannerView.frame.width, height: 8)
        UIView.animate(withDuration: 2) {
            self.scanLine.frame = CGRect(x: self.scanLine.frame.origin.x, y: self.scannerView.frame.maxY-10, width: self.scanLine.frame.width, height: self.scanLine.frame.height)
        }
    }
}
