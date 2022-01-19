//
//  HelpViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "HelpViewController.h"
#import "HelpView.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"紧急求助";
    [self setUpsubViews];
}

- (void)setUpsubViews {
    
    NSArray *helpArr = @[@{@"name":@"交通事故", @"number":@"112"},
                         @{@"name":@"急救中心", @"number":@"120"},
                         @{@"name":@"公安报警", @"number":@"110"},
                         @{@"name":@"消防报警", @"number":@"119"}];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT)];
    scrollView.backgroundColor = LColor(242, 242, 247);
    scrollView.contentSize = LSize(SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT);
    scrollView.scrollEnabled = YES;
    [self.view addSubview:scrollView];
    UIView *policeView = [[UIView alloc] initWithFrame:LRect(10, 10.f, SCREEN_WIDTH - 20.f, 150.f)];
    policeView.layer.cornerRadius = 8.f;
    [policeView.layer setMasksToBounds:YES];
    policeView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:policeView];
    UILabel *policeLabel = [[UILabel alloc] initWithFrame:LRect(10, 10, 80.f, 30.f)];
    policeLabel.text = @"紧急求助";
    policeLabel.font = [UIFont boldSystemFontOfSize:17.f];
//    policeLabel.backgroundColor = [UIColor yellowColor];
    [policeView addSubview:policeLabel];
    
    CGFloat width = (SCREEN_WIDTH - 50.f) / 2;
    CGFloat height = 40.f;
    CGFloat x;
    CGFloat y;
    for (int i = 0; i < 4; i++) {
        if (i%2 == 0) {
            x = 10;
        } else {
            x = width + 20.f;
        }
        if (i <= 1) {
            y = 50.f;
        } else {
            y = 100.f;
        }
        NSDictionary *dict = helpArr[i];
        NSString *name = dict[@"name"];
        NSString *number = dict[@"number"];
        HelpView *helpView = [[HelpView alloc] initWithName:name number:number];
//        helpView.backgroundColor = [UIColor purpleColor];
        helpView.frame = LRect(x, y, width, height);
        [policeView addSubview:helpView];
    }
    
    UIView *insurerView = [[UIView alloc] initWithFrame:LRect(10.f, 170.f, SCREEN_WIDTH - 20.f, 450.f)];
    insurerView.backgroundColor = [UIColor whiteColor];
    insurerView.layer.cornerRadius = 8.f;
    insurerView.layer.masksToBounds = YES;
    [scrollView addSubview:insurerView];
    UILabel *insurerLabel = [[UILabel alloc] initWithFrame:LRect(10.f, 10.f, 80.f, 30.f)];
    insurerLabel.text = @"保险公司";
    insurerLabel.font = [UIFont boldSystemFontOfSize:17.f];
//    insurerLabel.backgroundColor = [UIColor yellowColor];
    [insurerView addSubview:insurerLabel];
    
    NSArray *insurerArr = @[@[@{@"name":@"太平洋保险", @"number":@"95500"},@{@"name":@"太平保险", @"number":@"95589"}],
                            @[@{@"name":@"平安保险", @"number":@"95511"},@{@"name":@"中华保险", @"number":@"95585"}],
                            @[@{@"name":@"人保财险", @"number":@"95518"},@{@"name":@"大地保险", @"number":@"95590"}],
                            @[@{@"name":@"阳光保险", @"number":@"95510"},@{@"name":@"人寿保险", @"number":@"95519"}],
                            @[@{@"name":@"安邦财险", @"number":@"95569"},@{@"name":@"永安保险", @"number":@"95502"}],
                            @[@{@"name":@"天安保险", @"number":@"95505"},@{@"name":@"华寿财险", @"number":@"95509"}],
                            @[@{@"name":@"华安保险", @"number":@"95556"},@{@"name":@"寿康保险", @"number":@"95522"}],
                            @[@{@"name":@"都邦保险", @"number":@"95586"},@{@"name":@"永诚保险", @"number":@"95552"}]];
    for (int i = 0; i < insurerArr.count; i++) {
        for (int j = 0; j < 2; j++) {
            if (j%2 == 0) {
                x = 10;
            } else {
                x = width + 20.f;
            }
            y = 40.f + (i + 1) * 10.f + height * i;
            NSDictionary *dict = insurerArr[i][j];
            NSString *name = dict[@"name"];
            NSString *number = dict[@"number"];
            HelpView *helpView = [[HelpView alloc] initWithName:name number:number];
//            helpView.backgroundColor = [UIColor purpleColor];
            helpView.frame = LRect(x, y, width, height);
            [insurerView addSubview:helpView];
        }
    }
    
    
    
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
