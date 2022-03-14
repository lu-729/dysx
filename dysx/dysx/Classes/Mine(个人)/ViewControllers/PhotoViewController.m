//
//  PhotoViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "PhotoViewController.h"
#import "PhotoCollectionReusableView.h"
#import "PreviewPhotoViewController.h"
#import "BaseNavigationController.h"
#import "PhotoCollectionViewCell.h"
#import "LLCollectionView.h"

#define HeaderViewID @"PhotoCollectionReusableViewID"
#define CollectionViewCellWidth (SCREEN_WIDTH - 2*2.f) / 3

@interface PhotoViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UICollectionView * vedioCollectionView;
@property (nonatomic, strong) UICollectionView * photoCollectionView;
@property (nonatomic, strong) UITableView *vedioTableView;
@property (nonatomic, strong) UITableView *photoTableView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *collectionViewArr;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, assign) BOOL isSelected;
 
@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAIN_COLOR;
    self.title = @"本地相册";
    [self setUpSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


- (UITableView *)vedioTableView {
    if (!_vedioTableView) {
        _vedioTableView = [[UITableView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _vedioTableView.delegate = self;
        _vedioTableView.dataSource = self;
        _vedioTableView.backgroundColor = [UIColor redColor];
//        _vedioTableView.
    }
    return _vedioTableView;
}


- (UITableView *)photoTableView {
    if (!_photoTableView) {
        _photoTableView = [[UITableView alloc] initWithFrame:LRect(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT) style:UITableViewStylePlain];
        _photoTableView.delegate = self;
        _photoTableView.dataSource = self;
        _photoTableView.backgroundColor = [UIColor greenColor];
    }
    return _photoTableView;
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - HeightStatusBar - 50.f)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        //设置scrollview滑动范围
        _scrollView.contentSize = LSize(2 * SCREEN_WIDTH, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (UICollectionView *)vedioCollectionView {
    if (!_vedioCollectionView) {
        CGRect frame = LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.itemSize = LSize(80.f, 50.f);
        flowLayout.minimumInteritemSpacing = 2.f;
        flowLayout.minimumLineSpacing = 2.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _vedioCollectionView = [[LLCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _vedioCollectionView.tag = 100;
        _vedioCollectionView.delegate = self;
        _vedioCollectionView.dataSource = self;
        _vedioCollectionView.backgroundColor = [UIColor whiteColor];
        [_vedioCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"vedioCollectionViewCell"];
        [_vedioCollectionView registerClass:[PhotoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    }
    return _vedioCollectionView;
}


- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        CGRect frame = LRect(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//        flowLayout.itemSize = LSize(50.f, 50.f);
        flowLayout.minimumInteritemSpacing = 2.f;
        flowLayout.minimumLineSpacing = 2.f;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _photoCollectionView = [[LLCollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _photoCollectionView.tag = 101;
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.backgroundColor = [UIColor whiteColor];
        [_photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"photoCollectionViewCell"];
        [_photoCollectionView registerClass:[PhotoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    }
    return _photoCollectionView;
}


- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        NSArray *items = @[@"视频", @"图片"];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentedControl.frame = LRect(0, NAVBARHEIGHT, SCREEN_WIDTH - 100.f, 50.f);
        _segmentedControl.centerX = SCREEN_WIDTH / 2;
        _segmentedControl.selectedSegmentIndex = 0;
        [_segmentedControl addTarget:self action:@selector(segmentedControlClicked:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}



/// 创建导航栏右侧选择按钮
- (void)createNavBarRightBtn {
//    UIButton *rightChoiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    UIButton *rightChoiceBtn = [[UIButton alloc] init];;
    if (rightChoiceBtn) {
        _isSelected = NO;
        rightChoiceBtn.frame = LRect(0, 0, SCREEN_WIDTH / 5.0, 44.f);
        [rightChoiceBtn setTitle:@"选择" forState:UIControlStateNormal];
        [rightChoiceBtn setTitle:@"取消" forState:UIControlStateSelected];
        rightChoiceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16.f];
        [rightChoiceBtn setTitleColor:[UIColor systemBlueColor]];
        rightChoiceBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [rightChoiceBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -30)];
        [rightChoiceBtn addTarget:self action:@selector(choiceBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightChoiceBtn];
        if (rightItem) {
            self.navigationItem.rightBarButtonItem = rightItem;
        }
    }
}


- (void)choiceBtnAction:(UIButton *)button {
    _isSelected = !_isSelected;
    button.selected = _isSelected;
    //点击按钮时，切换控制器标题以及segmentedControl控件的交互功能
    if (_isSelected) {
        self.title = @"已选择%d张照片";
        _segmentedControl.userInteractionEnabled = NO;
        _scrollView.scrollEnabled = NO;
    } else {
        self.title = @"本地相册";
        _segmentedControl.userInteractionEnabled = YES;
        _scrollView.scrollEnabled = YES;
    }
    
    
    
    //使用颜色生成图片
    UIImage *normalImg = [UIImage imageWithColor:[UIColor whiteColor] size:LSize(10.f, 10.f)];
    UIImage *highlightedImg = [UIImage imageWithColor:[UIColor blueColor] size:LSize(10.f, 10.f)];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:normalImg highlightedImage:highlightedImg];
    
}

- (void)setUpSubViews {
    [self createNavBarRightBtn];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.vedioTableView];
    [self.scrollView addSubview:self.photoTableView];
//    [self.scrollView addSubview:self.vedioCollectionView];
//    [self.scrollView addSubview:self.photoCollectionView];
    
    
    /*
    NSArray *items = @[@"视频", @"图片"];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    [self.view addSubview:segmentedControl];
    __weak typeof(self) weakSelf = self;
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50.f);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(NAVBARHEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH - 100.f);
    }];
    */
    
    
    /*
    UIView *topBtnView = [[UIView alloc] init];
    topBtnView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topBtnView];
    __weak typeof(self) weakSelf = self;
    [topBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50.f);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.top.mas_equalTo(NAVBARHEIGHT);
        make.width.mas_equalTo(SCREEN_WIDTH - 100.f);
    }];
    NSArray *btnTitleArr = @[@"视频",@"图片"];
    CGFloat btnWidth = (SCREEN_WIDTH - 100) / 2;
    NSLog(@"topBtnView.width = %f", topBtnView.width);
    CGFloat btnHeight = 50.f;
    CGFloat btnY = 0;
    CGFloat btnX;
    for (int i = 0; i < btnTitleArr.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i + 100;
        btnX = i * btnWidth;
        button.frame = LRect(btnX, btnY, btnWidth, btnHeight);
        [button setTitleFont:15.f];
        [button setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:LColor(59, 135, 251) forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClicked:)];
        [topBtnView addSubview:button];
        if (i == 0) {
            _selectedBtn = button;
            _selectedBtn.selected = YES;
        }
    }
     */
    
}


- (void)segmentedControlClicked:(UISegmentedControl *)segmentedControl {
    NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
    if (selectedIndex == 0) {
        [_scrollView setContentOffset:LPoint(0, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:LPoint(SCREEN_WIDTH, 0) animated:YES];
    }
}


- (void)buttonClicked:(UIButton *)button {
    _selectedBtn.selected = NO;
    button.selected = YES;
    _selectedBtn = button;
    NSLog(@"button.tag = %ld", (long)button.tag);
    if (button.tag == 100) {
        NSLog(@"点击了视频按钮");
    } else {
        NSLog(@"点击了相册按钮");
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
        self.segmentedControl.selectedSegmentIndex = index;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"offset.x = %lf", offset.x);
    if (offset.x < 0) {
        scrollView.scrollEnabled = NO;
    }
}


#pragma mark - UICollectionViewDataSource Methods
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell;
    if (collectionView.tag == 100) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"vedioCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor yellowColor];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
    }
    NSLog(@"cell.frame = %@", cell);
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    return headerView;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}


#pragma mark - UICollectionViewDelegateFlowLayout Method


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectionViewCellHeight = CollectionViewCellWidth * (9.0 / 16) + 20.f;
    return CGSizeMake(CollectionViewCellWidth, collectionViewCellHeight);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return LSize(SCREEN_WIDTH, 30.f);
}


#pragma mark - UICollectionViewDelegate Methods


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld组,第%ld个", indexPath.section, indexPath.row);
    if (!_isSelected) {
#warning previewPhotoVC is to be review
    PreviewPhotoViewController *previewPhotoVC = [[PreviewPhotoViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:previewPhotoVC animated:YES];
    }
}


#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    return cell;
}



#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120.f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] initWithFrame:LRect(20.f, 0, 120.f, 30.f)];
    NSInteger num = 16;
    num += section;
    label.text = [NSString stringWithFormat:@"2022-3-%ld", num];
    label.font = [UIFont systemFontOfSize:14.f];
    [view addSubview:label];
    return view;
}



@end
