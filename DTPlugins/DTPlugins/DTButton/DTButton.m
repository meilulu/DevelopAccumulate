//
//  DTButton.m
//  DTPlugins
//
//  Created by 树妖 on 2019/6/19.
//  Copyright © 2019 树妖. All rights reserved.
//

#import "DTButton.h"
#import "Masonry.h"
@interface DTButton ()

@property (assign, nonatomic) CGFloat subviewDistance;

@end

@implementation DTButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.subviewDistance = 6;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
    }];
    
    CGFloat labelHeight = [self getTitleSize].height;
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self.imageView.mas_bottom).offset(self.subviewDistance);
        make.height.equalTo(@(labelHeight));
    }];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    
    [self layoutIfNeeded];
}

- (void)setImage:(UIImage *)image {
    if (!image) {
        return ;
    }
    
    self.imageView.image = image;
    
    [self layoutIfNeeded];
}

- (CGSize)getTitleSize {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    CGSize size = [self.titleLabel.text boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    return size;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

@end
