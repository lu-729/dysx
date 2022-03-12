//
//  QAViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "QAViewController.h"

@interface QAViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation QAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"常见问题";
    [self.view addSubview:self.tableView];
    [self addRefreshControl];
}


- (void)addRefreshControl {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
        [control addTarget:self action:@selector(reFreshstatus:) forControlEvents:UIControlEventValueChanged];
    control.attributedTitle = [[NSAttributedString alloc] initWithString:@"加载中..."];
        //不用自定义frame
        [self.tableView addSubview:control];
        //一进来就有刷新效果（但刷新数据是要手动的)
//    [control beginRefreshing];
    self.refreshControl = control;
}

- (void)reFreshstatus:(UIRefreshControl *)control {
    [control beginRefreshing];
    [self performSelector:@selector(changeData) withObject:nil afterDelay:1.5];
}


- (void)changeData {
    //加载数据
    [self.refreshControl endRefreshing];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor lightGrayColor];
    }
    return _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 18;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellReuseId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.text = @"Q:";
    cell.detailTextLabel.text = @"A:";
    cell.textLabel.font = [UIFont systemFontOfSize:14.f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
    return cell;
}



@end
