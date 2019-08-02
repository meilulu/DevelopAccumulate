//
//  DTTextView.h
//  DTPluginDemo
//
//  Created by 树妖 on 2019/6/18.
//  Copyright © 2019 树妖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTTextView : UITextView

@property (strong, nonatomic) UILabel *placeholderLabel;

#pragma mark - 输入文字字数
@property (strong, nonatomic) UILabel *characterCountLabel;
//最大字数限制，默认100
@property (assign, nonatomic) NSInteger maxCount;
//默认隐藏
@property (assign, nonatomic) BOOL countLabelHidden;

@end

NS_ASSUME_NONNULL_END
