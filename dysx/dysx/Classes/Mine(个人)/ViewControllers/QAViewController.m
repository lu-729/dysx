//
//  QAViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "QAViewController.h"

@interface QAViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation QAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"常见问题";
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
    }
    return _tableView;
}




@end
