//
//  DTPopoverView.h
//  ObjectiveCDemo
//
//  Created by 树妖 on 2019/1/10.
//  Copyright © 2019年 树妖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTPopoverView : UIView
@property (strong, nonatomic) NSString *text;
- (instancetype)initWithPoint:(CGPoint)centerPoint superView:(UIView *)superView orientation:(BOOL)up;
- (void)show;
@end

NS_ASSUME_NONNULL_END
