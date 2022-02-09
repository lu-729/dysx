//
//  PhotoViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "PhotoViewController.h"
#import "PhotoCollectionReusableView.h"

#define HeaderViewID @"PhotoCollectionReusableViewID"

@interface PhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UICollectionView * vedioCollectionView;
@property (nonatomic, strong) UICollectionView * photoCollectionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *collectionViewArr;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"本地相册";
    [self setUpSubViews];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - HeightStatusBar - 50.f)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        //设置scrollview滑动范围
        _scrollView.contentSize = LSize(2 * SCREEN_WIDTH, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = YES;
        _scrollView.showsVerticalScrollIndicator = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (UICollectionView *)vedioCollectionView {
    if (!_vedioCollectionView) {
        CGRect frame = LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = LSize(50.f, 50.f);
        flowLayout.minimumInteritemSpacing = 2.f;
        flowLayout.minimumLineSpacing = 2.f;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        _vedioCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _vedioCollectionView.tag = 100;
        _vedioCollectionView.delegate = self;
        _vedioCollectionView.dataSource = self;
        _vedioCollectionView.backgroundColor = [UIColor blueColor];
        [_vedioCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"vedioCollectionViewCell"];
        [_vedioCollectionView registerClass:[PhotoCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderViewID];
    }
    return _vedioCollectionView;
}


- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        CGRect frame = LRect(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = LSize(50.f, 50.f);
        flowLayout.minimumInteritemSpacing = 2.f;
        flowLayout.minimumLineSpacing = 2.f;
        flowLayout.sectionHeadersPinToVisibleBounds = YES;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        _photoCollectionView.tag = 101;
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
        _photoCollectionView.backgroundColor = [UIColor purpleColor];
        [_photoCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photoCollectionViewCell"];
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


- (void)setUpSubViews {
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.vedioCollectionView];
    [self.scrollView addSubview:self.photoCollectionView];
    
    
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



#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource Methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return LSize(SCREEN_WIDTH, 30.f);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld组,第%ld个", indexPath.section, indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return LSize((SCREEN_WIDTH - 25.f) / 4, (SCREEN_WIDTH - 25.f) / 4);
}



@end
