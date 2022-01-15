//
//  MainViewController.m
//  dysx
//
//  Created by wangyu on 2021/11/30.
//

#import "MainViewController.h"
//#import <IMSLinkVisualMedia/IMSLinkVisualMedia.h>

@interface MainViewController () {
    
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    NSLog(@"%f  %f  %f",UIWindowLevelNormal,UIWindowLevelAlert,UIWindowLevelStatusBar);
//    self.edgesForExtendedLayout	= UIRectEdgeNone;
    

    
    
}

- (void)initSubView {
    
}

    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
