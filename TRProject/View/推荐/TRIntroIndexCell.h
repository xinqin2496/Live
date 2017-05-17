//
//  TRIntroIndexCell.h
//  TRProject
//
//  Created by jiyingxin on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

#define kIntroIndexCellADICTag 1000
#define kIntroIndexCellHeaderICTag 2000

@interface TRIntroIndexCell : UICollectionViewCell

/** 头部广告滚动 */
@property (nonatomic) iCarousel *ic0;
/** 头像滚动视图 */
@property (nonatomic) iCarousel *ic1;

/** 广告滚动栏上的黑色蒙层 */
@property (nonatomic) UIView *grayView;
@property (nonatomic) UILabel *titleLb;
@property (nonatomic) UIPageControl *pageControl;

@property (nonatomic, weak) id<iCarouselDelegate, iCarouselDataSource> icDelegate;

@end
