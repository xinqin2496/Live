//
//  TRIntroSecionHeaderView.h
//  TRProject
//
//  Created by jiyingxin on 16/3/9.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TRIntroSectionHeaderView;

@protocol TRIntroSectionHeaderViewDelegate <NSObject>

/** 头部右侧按钮被点击后触发 */
- (void)introSectionHeaderView:(TRIntroSectionHeaderView *)headerView clickBtnAtIndexPath:(NSIndexPath *)indexPath;
@end

typedef NS_ENUM(NSUInteger, IntroBtnMode) {
    IntroBtnModeChange,
    IntroBtnModeMore,
};

@interface TRIntroSectionHeaderView : UICollectionReusableView

@property (nonatomic) UILabel *titleLb;
@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) IntroBtnMode btnMode;
@property (nonatomic) id<TRIntroSectionHeaderViewDelegate> delegate;
/** 换一换功能 */
@property (nonatomic) UIControl *changeControl;
/** 更多功能 */
@property (nonatomic) UIControl *moreControl;
@end
