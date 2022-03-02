//
//  PhotoCollectionViewCell.h
//  dysx
//
//  Created by chengbo on 2022/2/11.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *markImgView;
@property (nonatomic, assign) BOOL isChoice;

@end

NS_ASSUME_NONNULL_END
