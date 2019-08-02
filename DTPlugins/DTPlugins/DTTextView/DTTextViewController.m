//
//  DTTextViewController.m
//  DTPlugins
//
//  Created by 树妖 on 2019/6/18.
//  Copyright © 2019 树妖. All rights reserved.
//

#import "DTTextViewController.h"
#import "DTTextView.h"
@interface DTTextViewController ()

@property (strong, nonatomic) DTTextView *textView;

@end

@implementation DTTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"点击", nil) style:UIBarButtonItemStyleDone target:self action:@selector(doRightAction)];
    
    DTTextView *textView = [DTTextView new];
    self.textView = textView;
    textView.placeholderLabel.text = @"请输入...";
//    textView.maxCount = 200;
    textView.countLabelHidden = false;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@200);
    }];
    
}

- (void)doRightAction {
    [self.textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.height.equalTo(@200);
    }];
}

@end
