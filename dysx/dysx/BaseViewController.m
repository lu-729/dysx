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
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BOOL)prefersHomeIndicatorAutoHidden {
    return YES;
}

@end
