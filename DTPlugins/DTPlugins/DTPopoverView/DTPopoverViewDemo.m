//
//  DTPopoverViewDemo.m
//  DTPlugins
//
//  Created by 树妖 on 2018/12/19.
//  Copyright © 2018年 树妖. All rights reserved.
//

#import "DTPopoverViewDemo.h"
#import "DTPopoverView.h"

@interface DTPopoverViewDemo ()

@end

@implementation DTPopoverViewDemo

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = (UITouch *)touches.anyObject;
    CGPoint point = [touch locationInView:self.view];
    
    DTPopoverView *popover = [[DTPopoverView alloc] initWithPoint:point superView:self.view orientation:true];
    popover.text = @"氓之蚩蚩，抱布贸丝。匪来贸丝，来即我谋。\n送子涉淇，至于顿丘。匪我愆期，子无良媒。\n将子无怒，秋以为期";
    [popover show];
}
@end
