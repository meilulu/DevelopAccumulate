//
//  ThirdCell.swift
//  SwiftDemo
//
//  Created by ShareAnimation on 2018/3/8.
//  Copyright © 2018年 爱丽丝的梦境. All rights reserved.
//

import UIKit
import FoldingCell

class ThirdCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
