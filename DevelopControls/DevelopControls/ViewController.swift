//
//  ViewController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/1/18.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import SnapKit

func colorWith255RGB(_ r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
}

class ViewController: UIViewController {
    
    fileprivate var _tableView:UITableView!
    fileprivate var tableView:UITableView {
        get {
            if _tableView != nil {
                return _tableView
            }
            _tableView = UITableView()
            _tableView.delegate = self
            _tableView.dataSource = self
            _tableView.tableFooterView = UIView()
            _tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            _tableView.separatorStyle = .none
            _tableView.showsVerticalScrollIndicator = false
            
            
            return _tableView
        }
    }
    
    var targetControllers = [UIViewController]()
    var targetTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主"
        self.view.backgroundColor = UIColor.white
        
        targetControllers = [QRCodeScannerController(),LoadingViewController(),HomeDynamicChangeController()]
        targetTitles = ["二维码扫描","加载页","TableViewCell动态变化"]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "测试", style: .done, target: self, action: #selector(doRightAction))
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    @objc func doRightAction() {
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return targetControllers.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = targetTitles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = targetControllers[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
