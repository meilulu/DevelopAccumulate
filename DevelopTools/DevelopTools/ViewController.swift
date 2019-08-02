//
//  ViewController.swift
//  DevelopTools
//
//  Created by ShareAnimation on 2018/1/17.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主"
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "登录相关"
        }
        else {
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(LoginHomeController(), animated: true);
        }
    }
}

