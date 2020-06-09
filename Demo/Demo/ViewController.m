//
//  ViewController.m
//  Demo
//
//  Created by 似水灵修 on 2020/6/8.
//  Copyright © 2020 似水灵修. All rights reserved.
//

#import "ViewController.h"
#import "LYHUD.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIStackView *stackView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stackView = [[UIStackView alloc] initWithFrame:self.view.bounds];
    self.stackView.axis = UILayoutConstraintAxisHorizontal;
    self.stackView.distribution = UIStackViewDistributionFillEqually;
    [self.view addSubview:self.stackView];
    
    for (int i = 0; i < 5; i++) {
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        addBtn.tag = 1000 + i;
        [addBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.stackView addArrangedSubview:addBtn];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.stackView.frame = self.view.bounds;
}

- (void)btnClick:(UIButton *)btn {
    NSInteger tag = btn.tag - 1000;
    NSString *msg = @"加载中...";
    if (tag == 0) {
        [LYHUD showHUD:msg];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LYHUD hideHUD];
        });
    } else if (tag == 1) {
        [LYHUD showMessage:msg style:LYHUDStyleSuccess completion:^{
            
        }];
    } else if (tag == 2) {
        [LYHUD showMessage:msg style:LYHUDStyleFailure completion:^{
            
        }];
    } else {
        [LYHUD showMessage:msg style:LYHUDStyleNone completion:^{
            [self presentViewController:[[ViewController alloc] init] animated:YES completion:nil];
        }];
    }
}

- (void)dealloc {
    NSLog(@"%@", self);
}

@end
