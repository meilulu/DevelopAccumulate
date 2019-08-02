//
//  DTButton.h
//  DTPlugins
//
//  Created by 树妖 on 2019/6/19.
//  Copyright © 2019 树妖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTButton : UIControl

@property (strong, nonatomic)UILabel *titleLabel;
- (void)setTitle:(NSString *)title;

@property (strong, nonatomic) UIImageView *imageView;
- (void)setImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
