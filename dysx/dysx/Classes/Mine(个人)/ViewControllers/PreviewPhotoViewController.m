//
//  PreviewPhotoViewController.m
//  dysx
//
//  Created by chengbo on 2022/2/10.
//

#import "PreviewPhotoViewController.h"

@interface PreviewPhotoViewController ()

@property (nonatomic, strong) NSArray *photoArr;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation PreviewPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"时间";
    [self setupSubViews];
}


- (void)setupSubViews {
    _bgView = [[UIView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, 250.f)];
    _bgView.backgroundColor = [UIColor systemGrayColor];
    _bgView.center = LPoint(SCREEN_WIDTH / 2.0, SCREEN_HEIGHT / 2.0 - 80.f);
    [self.view addSubview:_bgView];
}

- (void)backButtonAction {
    
}



@end
