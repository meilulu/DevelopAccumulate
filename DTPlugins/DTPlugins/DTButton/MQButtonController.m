//
//  MQButtonController.m
//  DTPlugins
//
//  Created by 树妖 on 2019/3/30.
//  Copyright © 2019年 树妖. All rights reserved.
//

#import "MQButtonController.h"
#import "DTButton.h"
#import "Masonry.h"

@interface MQButtonController ()

@end

@implementation MQButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupViews];
}

- (void)setupViews {
    DTButton *button = [DTButton new];
    [button addTarget:self action:@selector(doButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"给你点赞"];
    [button setImage:[UIImage imageNamed:@"dianzan1-2"]];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)doButtonAction {
    NSLog(@"点赞");
}
@end
