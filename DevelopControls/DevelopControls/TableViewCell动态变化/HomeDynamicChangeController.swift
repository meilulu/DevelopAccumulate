//
//  HomeDynamicChangeController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/3/9.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit

class HomeDynamicChangeController: UIViewController {
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

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "点击", style: .done, target: self, action: #selector(doRightAction))
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    @objc func doRightAction() {
        
    }

}

extension HomeDynamicChangeController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if indexPath.row == 0 {
            cell.textLabel?.text = "第一种"
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "第二种"
        }
        else {
            cell.textLabel?.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(FirstDynamicViewController(), animated: true)
        }
        if indexPath.row == 1 {
            self.navigationController?.pushViewController(ThirdViewController(), animated: true)
        }
    }
    
}
