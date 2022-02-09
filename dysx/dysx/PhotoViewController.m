//
//  PhotoViewController.m
//  dysx
//
//  Created by chengbo on 2022/1/17.
//

#import "PhotoViewController.h"

@interface PhotoViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UICollectionView * vedioCollectionView;
@property (nonatomic, strong) UICollectionView * photoCollectionView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *collectionViewArr;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"本地相册";
    [self setUpSubViews];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:LRect(0, HeightStatusBar + 50.f, SCREEN_WIDTH * 2, SCREEN_HEIGHT - HeightStatusBar - 50.f)];
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor whiteColor];
        //设置scrollview滑动范围
        _scrollView.contentSize = LSize(SCREEN_WIDTH * 2, _scrollView.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}


- (UICollectionView *)vedioCollectionView {
    if (!_vedioCollectionView) {
        CGRect frame = LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = LSize(50.f, 50.f);
        layout.minimumInteritemSpacing = 2.f;
        layout.minimumLineSpacing = 2.f;
        _vedioCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _vedioCollectionView.delegate = self;
        _vedioCollectionView.dataSource = self;
    }
    return _vedioCollectionView;
}


- (UICollectionView *)photoCollectionView {
    if (!_photoCollectionView) {
        CGRect frame = LRect(SCREEN_WIDTH, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f);
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = LSize(50.f, 50.f);
        layout.minimumInteritemSpacing = 2.f;
        layout.minimumLineSpacing = 2.f;
        _photoCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        _photoCollectionView.delegate = self;
        _photoCollectionView.dataSource = self;
    }
    return _photoCollectionView;
}

- (void)setUpSubViews {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.vedioCollectionView];
    [self.scrollView addSubview:self.photoCollectionView];
    
    
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
    
//    UIScrollView *photoScrollView = [[UIScrollView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f)];
//    photoScrollView.contentSize = LSize(2 * SCREEN_WIDTH, SCREEN_HEIGHT);
//    [self.view addSubview:photoScrollView];
    
    /*
    for (int i = 0; i<2; i++) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = SCREEN_WIDTH / 4;
        [flowLayout setItemSize:LSize(itemWidth, itemWidth)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.sectionInset = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
    //    _collectionView = [[UICollectionView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f)];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"sdfshfkdshk"];
        [self.scrollView addSubview:collectionView];
        [self.collectionViewArr addObject:collectionView];
    }
    self.collectionView = self.collectionViewArr.firstObject;
    [self.view addSubview:self.scrollView];
    */
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    CGFloat itemWidth = SCREEN_WIDTH / 4;
//    [flowLayout setItemSize:LSize(itemWidth, itemWidth)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.sectionInset = UIEdgeInsetsMake(5.f, 5.f, 5.f, 5.f);
//    _collectionView = [[UICollectionView alloc] initWithFrame:LRect(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f)];
//    _collectionView = [[UICollectionView alloc] initWithFrame:LRect(0, NAVBARHEIGHT + 50.f, SCREEN_WIDTH, SCREEN_HEIGHT - NAVBARHEIGHT - 50.f) collectionViewLayout:flowLayout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    _collectionView.backgroundColor = [UIColor clearColor];
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"sdfshfkdshk"];
//
//    [self.view addSubview:_collectionView];
    
    CGFloat scale = 1.0 / [UIScreen mainScreen].scale;
    CGFloat space = scale;
    
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






#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource Methods

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sdfshfkdshk" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    NSLog(@"cell.frame = %@", cell);
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 9;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击了第%ld组,第%ld个", indexPath.section, indexPath.row);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return LSize((SCREEN_WIDTH - 25.f) / 4, (SCREEN_WIDTH - 25.f) / 4);
}



@end
