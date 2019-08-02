//
//  ThirdViewController.swift
//  SwiftDemo
//
//  Created by ShareAnimation on 2018/3/8.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import FoldingCell
class ThirdViewController: UIViewController {
    
    let kCloseCellHeight: CGFloat = 90
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
            _tableView.estimatedRowHeight = kCloseCellHeight
            _tableView.rowHeight = UITableViewAutomaticDimension
            _tableView.register(UINib.init(nibName: "ThirdCell", bundle: nil), forCellReuseIdentifier: "cell")
            
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


extension ThirdViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kRowsCount
    }
    
    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as ThirdCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
    }

    
    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FoldingCell
//        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
//        cell.durationsForExpandedState = durations
//        cell.durationsForCollapsedState = durations
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }

        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
        }
        else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

