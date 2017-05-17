//
//  TRIntroViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRIntroViewController.h"
#import "TRIntroIndexCell.h"
#import "TRIntroViewModel.h"
#import "iCarousel.h"
#import "TRCategoryCell.h"
#import "TRIntroSectionHeaderView.h"
#import "TRCategoryViewController.h"
#import "TRSearchViewController.h"
#import "PlayerModel.h"
#import "TRLiveNetManager.h"
#import "TRDataManager.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "PlayerViewController.h"
#import "PlayController.h"
#import "TRCategoriesViewModel.h"
#import "TRCategoryViewController.h"
#import "TRFocusOnViewController.h"
#import "TRGiftView.h"
#import "TRTopUpViewController.h"
#import "TRFocusViewController.h"

#define kCellSpace          8
#define kCellNumPerLine     2

#define Ratio 618/480
@interface TRIntroViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, iCarouselDelegate, iCarouselDataSource, TRIntroSectionHeaderViewDelegate,CardDownAnimationViewDelegate>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) TRIntroViewModel *introVM;
//存储头部滚动视图
@property (nonatomic, strong)NSArray * dataArray;
@property (nonatomic) TRCategoriesViewModel *categoriesVM;
/** 礼物视图 */
@property (nonatomic,strong)TRGiftView *giftView;

@end

@implementation TRIntroViewController

#pragma mark - 弹出视图消失或者选择了相应delegate
//卡片视图消失时候的代理
-  (void)cardDownAnimationViewDidHide:(CardDownAnimationView *)cardDownView {
     if (cardDownView==self.giftView) {
        [self.giftView removeFromSuperview];
        self.giftView = nil;
    }
}

//点击搜索
- (IBAction)clickSearchBtn:(id)sender
{
   
    TRSearchViewController *vc = [TRSearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
//点击关注
- (IBAction)clickFollowBtn:(id)sender
{
    TRUserInfo *userInfo = [TRUserInfo new];
    if (!userInfo.isLogin) {
        [self.view showWarning:@"请先登录"];
    }else{
    TRFocusViewController *focusVC = [TRFocusViewController new];

    focusVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:focusVC animated:YES];
    }
}
//点击礼物
- (IBAction)clickGiftBtn:(id)sender
{
    self.giftView = [TRGiftView new];
    self.giftView.delegate = self;
    [self.giftView.top_upBtn bk_addEventHandler:^(id sender) {
        [self.giftView hide];
        TRTopUpViewController *topVC = [TRTopUpViewController new];
        topVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:topVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.giftView show];
}

- (TRCategoriesViewModel *)categoriesVM {
    if(_categoriesVM == nil) {
        _categoriesVM = [[TRCategoriesViewModel alloc] init];
    }
    return _categoriesVM;
}
- (void)loadData {

    [TRLiveNetManager getScrollViewCompletionHandler:^(id responseObject, NSError *error) {

        self.dataArray = [TRDataManager getAllTopScrollViewData:responseObject];

        [self.collectionView beginHeaderRefresh];
    }];
    
}

#pragma mark - TRIntroSectionHeaderView delegate
//点击换一换还是更多
- (void)introSectionHeaderView:(TRIntroSectionHeaderView *)headerView clickBtnAtIndexPath:(NSIndexPath *)indexPath{
    switch (headerView.btnMode) {
        case IntroBtnModeChange: {
            [self.introVM changeCurrentRecommentList];
            [_collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
            break;
        }
        case IntroBtnModeMore: {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
            TRCategoryViewController *vc = [[TRCategoryViewController alloc] initWithSlug:[self.introVM linkSlugForIndexPath:tmpIndexPath] categoryName:[self.introVM linkCategoryNameForIndexPath:tmpIndexPath]];
            
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
    }
}

#pragma mark - ICarousel delegate
//头部滚动
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    if (carousel.tag == kIntroIndexCellADICTag) {
        return self.dataArray.count;
    }
    //明星的个数
//    return self.introVM.starNumber;
    //分类的个数
    return self.categoriesVM.rowNumber;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view{
    if (carousel.tag == kIntroIndexCellADICTag) {
        if (!view) {
           
            view = [[UIView alloc] initWithFrame:carousel.bounds];
            view.clipsToBounds = YES;
            UIImageView *iconIV = [UIImageView new];
            [view addSubview:iconIV];
            [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(0);  
            }];

            iconIV.tag = 10000;
        }
        UIImageView *iconIV = (UIImageView *)[view viewWithTag:10000];
        PlayerModel *playModel = self.dataArray[index];
        NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",playModel.portrait]];
        [iconIV sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"分类"]];

        return view;
    }else{
        if (!view) {
            view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80, carousel.bounds.size.height)];
            view.clipsToBounds = YES;
            UILabel *nameLb = [UILabel new];
             nameLb.font = [UIFont systemFontOfSize:12];
            [view addSubview:nameLb];
            [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(0);
                make.bottom.equalTo(-5);
            }];
            nameLb.tag = 100;
            UIImageView *iconIV = [[UIImageView alloc] init];
            [view addSubview:iconIV];
            [iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(0);
                make.top.equalTo(10);
                make.size.equalTo(CGSizeMake(50, 50));
            }];
            iconIV.clipsToBounds = YES;
            iconIV.layer.cornerRadius = 25;
            iconIV.tag = 200;
        }
        
        UILabel *nameLb = (UILabel *)[view viewWithTag:100];
        nameLb.font = [UIFont systemFontOfSize:12];
//        nameLb.text = [self.introVM starNameForIndex:index];//明星的
        
        nameLb.text  = [self.categoriesVM titleForRow:index];//分类的
        
        UIImageView *iconIV = (UIImageView *)[view viewWithTag:200];
//        [iconIV sd_setImageWithURL:[self.introVM starIconURLForIndex:index] placeholderImage:[UIImage imageNamed:@"分类"]];//明星
        
        [iconIV sd_setImageWithURL:[self.categoriesVM iconURLForRow:index] placeholderImage:[UIImage imageNamed:@"分类"]];
       
        return view;
    }
    return nil;
}
- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
//    if (carousel.tag == kIntroIndexCellADICTag) {
    if (option == iCarouselOptionWrap) {
        return YES;
    }
//    }

    return value;
}
//点击播放
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    if (carousel.tag == kIntroIndexCellADICTag) {
         PlayerModel *PlayerModel = self.dataArray[index];

        
        PlayerViewController * playerVc = [[PlayerViewController alloc] init];
        // 直播url
        playerVc.liveStr = PlayerModel.liveURL;
     
        // 直播图片
        playerVc.imageStr = PlayerModel.portrait;
        playerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:playerVc animated:YES];
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
       
    }else{
        //点击明星播放
//        NSString *urlStr = [[self.introVM starVideoURLForIndex:index]absoluteString];
//      
//        PlayController *pVC = [[PlayController alloc]init];
//        pVC.Hls_url = urlStr;
//        pVC.Hls_name = [self.introVM starNameForIndex:index];
//        pVC.Hls_imageURL = [self.introVM starIconURLForIndex:index];
//
//        [self presentViewController:pVC animated:YES completion:nil];
  
        //点击跳转到详细
        TRCategoryViewController *vc = [[TRCategoryViewController alloc] initWithSlug:[self.categoriesVM slugForRow:index] categoryName:[self.categoriesVM categoryNameForRow:index]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    if (carousel.tag == kIntroIndexCellADICTag) {
        NSInteger index = carousel.currentItemIndex;
        TRIntroIndexCell *cell = (TRIntroIndexCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        PlayerModel *playModel = self.dataArray[index];
        cell.titleLb.text = playModel.name;
        cell.pageControl.currentPage = index;
    }
}

#pragma mark - UICollectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2 + self.introVM.linkNumber;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 2;
    }
    return [self.introVM linkNumberForSection:section-2];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {//头像和头部滚动
        TRIntroIndexCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRIntroIndexCell" forIndexPath:indexPath];
        cell.icDelegate = self;
        cell.pageControl.numberOfPages = self.introVM.indexNumber;
        cell.pageControl.currentPage = 0;
        cell.titleLb.text = [self.introVM indexTitleForIndex:indexPath.row];
        [cell.ic0 reloadData];
        [cell.ic1 reloadData];
        return cell;
    }else if (indexPath.section == 1) {//推荐
        TRCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRCategoryCell" forIndexPath:indexPath];
        NSInteger row = indexPath.row;
        cell.titleLb.text = [self.introVM recommendTitleForRow:row];
        cell.viewLb.text = [self.introVM recommendViewForRow:row];
        
        cell.nickLb.text = [self.introVM recommendNickForRow:row];
        [cell.avatarIV sd_setImageWithURL:[self.introVM recommendAvatarIconURLForRow:row] placeholderImage:[UIImage imageNamed:@"分类"]];
        [cell.iconIV sd_setImageWithURL:[self.introVM recommendIconURLForRow:row] placeholderImage:[UIImage imageNamed:@"分类"]];
        
        return cell;
    }else{//其他分类
        TRCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TRCategoryCell" forIndexPath:indexPath];
        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
        cell.titleLb.text = [self.introVM linkTitleForIndexPath:tmpIndexPath];
        cell.viewLb.text = [self.introVM linkViewForIndexPath:tmpIndexPath];
        cell.nickLb.text = [self.introVM linkNickForIndexPath:tmpIndexPath];
        [cell.iconIV sd_setImageWithURL:[self.introVM linkIconURLForIndexPath:tmpIndexPath] placeholderImage:[UIImage imageNamed:@"分类"]];
         [cell.avatarIV sd_setImageWithURL:[self.introVM linkAvatarIconURLForIndexPath:tmpIndexPath] placeholderImage:[UIImage imageNamed:@"分类"]];
        return cell;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section != 0) {
        return UIEdgeInsetsMake(kCellSpace, kCellSpace, kCellSpace, kCellSpace);
    }
    return UIEdgeInsetsZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //0  748  416
    if (indexPath.section == 0){
        return CGSizeMake(kScreenW, kScreenW * 416/ 748 + 90);
    }else{
        CGFloat width = (kScreenW - (kCellNumPerLine + 1) * kCellSpace)/kCellNumPerLine;
        //        350 * 266
        CGFloat height = 266 * width / 350;
        return CGSizeMake(width, height);
    }
    return CGSizeZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section  != 0) {
        return kCellSpace;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section  != 0) {
        return kCellSpace;
    }
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {

        //使用自定义的播放样式
        PlayController *pvc = [[PlayController alloc]init];
        pvc.Hls_onlines = [self.introVM recommendViewForRow:indexPath.row];
        pvc.Hls_liveStr= [[self.introVM recommendVideoURLForRow:indexPath.row]absoluteString];
        pvc.Hls_name = [self.introVM recommendNickForRow:indexPath.row];
        pvc.Hls_avatarURL = [self.introVM recommendAvatarIconURLForRow:indexPath.row];
        pvc.Hls_imageURL = [self.introVM recommendIconURLForRow:indexPath.row];
        pvc.Hls_title = [self.introVM recommendTitleForRow:indexPath.row];
        [self presentViewController:pvc animated:YES completion:nil];
    }
    if (indexPath.section > 1) {
        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
        
        PlayController *pvc = [[PlayController alloc]init];
        pvc.Hls_onlines = [self.introVM linkViewForIndexPath:tmpIndexPath];
        pvc.Hls_liveStr = [[self.introVM linkVideoURLForIndexPath:tmpIndexPath]absoluteString];
        pvc.Hls_name = [self.introVM linkNickForIndexPath:tmpIndexPath];
        pvc.Hls_title = [self.introVM linkTitleForIndexPath:tmpIndexPath];
        pvc.Hls_avatarURL = [self.introVM linkAvatarIconURLForIndexPath:tmpIndexPath];
        pvc.Hls_imageURL = [self.introVM linkIconURLForIndexPath:tmpIndexPath];
        [self presentViewController:pvc animated:YES completion:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeZero;
    }
    return CGSizeMake(kScreenW, 35);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return nil;
    }
    TRIntroSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TRIntroSectionHeaderView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    if (indexPath.section == 1) {
        headerView.btnMode = IntroBtnModeChange;
        headerView.titleLb.text = @"精彩推荐";
    }
    if (indexPath.section > 1) {
        headerView.btnMode = IntroBtnModeMore;
        NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section - 2];
        headerView.titleLb.text = [self.introVM linkCategoryNameForIndexPath:tmpIndexPath];
    }
    headerView.indexPath = indexPath;
    headerView.delegate = self;
    return headerView;
}

#pragma mark - Life 
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 加载数据
    [self loadData];
   
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.shadowImage =[UIImage new];
  
    [self.collectionView beginHeaderRefresh];
    

    //添加搜索
//    [Factory addSearchItemToVC:self clickHandler:^{
//        TRSearchViewController *vc = [TRSearchViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[UICollectionViewFlowLayout new]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TRIntroIndexCell class] forCellWithReuseIdentifier:@"TRIntroIndexCell"];
        [_collectionView registerClass:[TRCategoryCell class] forCellWithReuseIdentifier:@"TRCategoryCell"];
        
        [_collectionView registerClass:[TRIntroSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TRIntroSectionHeaderView"];
        WK(weakSelf);
        [_collectionView addHeaderRefresh:^{
            [weakSelf.introVM getDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
                if (!error) {
                    [weakSelf.collectionView reloadData];
                }
                [weakSelf.collectionView endHeaderRefresh];
            }];
            [weakSelf.categoriesVM getDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
                if (!error) {
                    [weakSelf.collectionView reloadData];
                }
                [weakSelf.collectionView endHeaderRefresh];
            }];
        }];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
        }];
        _collectionView.backgroundColor = kBGColor;
    }
    return _collectionView;
}

- (TRIntroViewModel *)introVM {
    if(_introVM == nil) {
        _introVM = [[TRIntroViewModel alloc] init];
    }
    return _introVM;
}

@end
