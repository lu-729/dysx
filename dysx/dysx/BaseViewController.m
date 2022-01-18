//
//  BaseViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

@end
