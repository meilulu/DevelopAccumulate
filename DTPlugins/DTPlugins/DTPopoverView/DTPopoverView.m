//
//  DTPopoverView.m
//  ObjectiveCDemo
//
//  Created by 树妖 on 2019/1/10.
//  Copyright © 2019年 树妖. All rights reserved.
//

#import "DTPopoverView.h"
#import "Masonry.h"

typedef NS_ENUM(NSInteger, MQPopoverViewArrowPosition) {
    MQPopoverViewArrowPositionNormal=0,
    MQPopoverViewArrowPositionTop,
    MQPopoverViewArrowPositionBottom

};
@interface DTPopoverView()
@property (strong, nonatomic) UIView *panelView;
@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIView *superView;

@property (assign, nonatomic) CGPoint keyPoint;
@property (assign, nonatomic) CGFloat arrowWidth;
@property (assign, nonatomic) CGFloat arrowHeight;

@property (assign, nonatomic) CGFloat screenWidth;
@property (assign, nonatomic) CGFloat screenHeight;

@property (nonatomic) BOOL upOrientation;
@end
@implementation DTPopoverView

- (instancetype)initWithPoint:(CGPoint)centerPoint superView:(UIView *)superView orientation:(BOOL)up {
    if (self = [super init]) {
        self.superView = superView;
        self.keyPoint = centerPoint;
        
        self.arrowWidth = 11;
        self.arrowHeight = 7;
        
        self.screenWidth = superView.bounds.size.width;
        self.screenHeight = superView.bounds.size.height;
        
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    NSDictionary *dict = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:12]
                           };
    CGSize size = [text boundingRectWithSize:CGSizeMake(9999,9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    self.textLabel.frame = CGRectMake(0, 0, size.width, size.height);
    self.textLabel.text = text;
}

- (void)show {
    //将之前的剔除
    UIView *oldView = [self.superView viewWithTag:9999999];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    self.tag = 9999999;
    
    [self.superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superView).offset(self.keyPoint.x);
        make.top.equalTo(self.superView).offset(self.keyPoint.y);
    }];

    
    [self addSubview:self.panelView];
    [self.panelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(self.arrowHeight);
        make.bottom.equalTo(self).offset(-self.arrowHeight);
    }];
    
    [self.panelView addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.panelView).insets(UIEdgeInsetsMake(5, 5, 5, 5));
    }];
    
    [self.superView layoutIfNeeded];
    
    CGSize panelSize = self.panelView.bounds.size;
    CGSize contentSize = self.bounds.size;
    
    //箭头方向
    MQPopoverViewArrowPosition direction = [self arrowPositionWithPoint:self.keyPoint contentSize:panelSize];

    //内容位置
    [self contentCenterWithContentSize:contentSize arrowPosition:direction];
    
    
    //小三角
    CALayer *arrowLayer = [self drawArrowWithPosition:direction contentSize:self.panelView.bounds.size];
    [self.layer addSublayer:arrowLayer];
    
    
    [self endPopWithAnimation];
}

- (void)contentCenterWithContentSize:(CGSize)contentSize arrowPosition:(MQPopoverViewArrowPosition)position{
    //位置偏移
    CGFloat contentOffset = 0;
    //内容超出左边界
    if (self.keyPoint.x<contentSize.width/2) {
        contentOffset = contentSize.width/2-self.keyPoint.x;
    }
    //内容超出右边界
    if (self.screenWidth-self.keyPoint.x<contentSize.width/2) {
        contentOffset = -(contentSize.width/2 - (self.screenWidth-self.keyPoint.x));
    }
    
    CGFloat pointX = self.center.x-self.panelView.bounds.size.width/2 + contentOffset;
    if (position==MQPopoverViewArrowPositionTop){
        self.center = CGPointMake(pointX, self.center.y);
    }
    else {
        self.center = CGPointMake(pointX, self.center.y-contentSize.height);
    }
}

- (MQPopoverViewArrowPosition)arrowPositionWithPoint:(CGPoint)keyPoint contentSize:(CGSize)contentSize {
//    CGPoint point = [self.superView convertPoint:keyPoint toView:self.window];
//    if (self.upOrientation) {
//        point = point;
//    }
//    else {
//        point = CGPointMake(point.y, point.x);
//    }
    CGPoint point = keyPoint;
    if (self.screenHeight-point.y>=contentSize.height) {
        return MQPopoverViewArrowPositionTop;
    }
    else {
        return MQPopoverViewArrowPositionBottom;
    }
}

//绘制小三角
- (CALayer *)drawArrowWithPosition:(MQPopoverViewArrowPosition)position contentSize:(CGSize)contentSize {
    CGPoint pointA;
    CGPoint pointB;
    CGPoint pointC;
    
    CGFloat arrowTopX = [self.superView convertPoint:self.keyPoint toView:self].x;
    if (arrowTopX<=self.arrowHeight) {
        arrowTopX=self.arrowHeight;
    }
    if (arrowTopX>=self.frame.size.width-self.arrowHeight) {
        arrowTopX = self.frame.size.width-self.arrowHeight;
    }
    
    CGFloat width = self.arrowWidth;
    CGFloat height = self.arrowHeight;
    if (position == MQPopoverViewArrowPositionTop) {
        pointA = CGPointMake(arrowTopX, 0);
        pointB = CGPointMake(arrowTopX-width/2, height);
        pointC = CGPointMake(arrowTopX+width/2, self.arrowHeight);
    }
    else {
        pointA = CGPointMake(arrowTopX, contentSize.height+2*height);
        pointB = CGPointMake(arrowTopX-width/2, contentSize.height+height);
        pointC = CGPointMake(arrowTopX+width/2, contentSize.height+height);
    }
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:pointA];
    [path addLineToPoint:pointB];
    [path addLineToPoint:pointC];
    path.lineWidth = 1.0;
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    arrowLayer.path = path.CGPath;
    arrowLayer.fillColor = [UIColor colorWithWhite:0 alpha:0.4].CGColor;
    return arrowLayer;
}

- (void)endPopWithAnimation {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    }
    return hitView;
}

- (UILabel *)textLabel {
    if(!_textLabel) {
        _textLabel = [UILabel new];
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.font = [UIFont systemFontOfSize:12];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.numberOfLines = 0;
        _textLabel.preferredMaxLayoutWidth = self.screenWidth-50;
    }
    return _textLabel;
}

- (UIView *)panelView {
    if (!_panelView) {
        _panelView = [UIView new];
        _panelView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        _panelView.layer.cornerRadius = 3.0;
    }
    return _panelView;
}
@end
