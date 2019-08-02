//
//  FirstDynamicViewController.swift
//  DevelopControls
//
//  Created by ShareAnimation on 2018/3/9.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit

class FirstDynamicViewController: UIViewController {
    
    let kCloseCellHeight: CGFloat = 95
    let kOpenCellHeight: CGFloat = 170
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    
    var _tableView:UITableView!
    var tableView:UITableView {
        get {
            if _tableView != nil {
                return _tableView
            }
            _tableView = UITableView()
            _tableView.delegate = self
            _tableView.dataSource = self
            _tableView.estimatedRowHeight = 44
            _tableView.rowHeight = UITableViewAutomaticDimension
            _tableView.register(FirstDynamicCell.self, forCellReuseIdentifier: "cell")
            
            return _tableView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
}

extension FirstDynamicViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kRowsCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let cell = cell as? FirstDynamicCell else {
            return
        }
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false)
        } else {
            cell.unfold(true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FirstDynamicCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
        }
        else {
            cellHeights[indexPath.row] = kCloseCellHeight
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

