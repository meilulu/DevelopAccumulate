//
//  DTScratchCard.m
//  Objective-CDemo2
//
//  Created by 树妖 on 2019/7/18.
//  Copyright © 2019 树妖. All rights reserved.
//

#import "DTScratchCard.h"
#import "Masonry.h"
@interface DTScratchCard()
@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) CAShapeLayer *maskLayer;

@property (strong, nonatomic) UIBezierPath *bezierPath;

@end
@implementation DTScratchCard

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        self.imageView = [UIImageView new];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        self.imageView.layer.mask = self.maskLayer;
        
        self.bezierPath = [UIBezierPath bezierPath];
    }
    return self;
}

- (void)setContentImage:(UIImage *)contentImage {
    _contentImage = contentImage;
    
    self.imageView.image = contentImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.bezierPath moveToPoint:currentPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint currentPoint = [touch locationInView:self];
    
    [self.bezierPath addLineToPoint:currentPoint];
    self.maskLayer.path = self.bezierPath.CGPath;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.strokeColor = [UIColor blackColor].CGColor;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.lineCap = kCALineCapRound;
        _maskLayer.lineWidth = 25;
        _maskLayer.lineJoin = kCALineJoinRound;
    }
    return _maskLayer;
}
@end
