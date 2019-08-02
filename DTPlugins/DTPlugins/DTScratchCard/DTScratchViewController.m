//
//  DTScratchViewController.m
//  DTPlugins
//
//  Created by 树妖 on 2019/7/19.
//  Copyright © 2019 树妖. All rights reserved.
//

#import "DTScratchViewController.h"
#import "DTScratchCard.h"
@interface DTScratchViewController ()

@end

@implementation DTScratchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    DTScratchCard *card = [DTScratchCard new];
    [self.view addSubview:card];
    card.contentImage = [UIImage imageNamed:@"IMG_1162"];
    [card mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}
@end
