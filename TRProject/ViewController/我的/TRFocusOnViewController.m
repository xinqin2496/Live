//
//  TRFocusOnViewController.m
//  TRProject
//
//  Created by 郑文青 on 16/7/26.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRFocusOnViewController.h"
#import "TRCategoryCell.h"
#import "PlayController.h"
#import "TRFocusModel.h"
#define kCellSpace          8
#define kCellNumPerLine     2
@interface TRFocusOnViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;

/** 从focus数据库中把关注取出来 */
@property (nonatomic,strong)NSArray *allFocusArr;
@end

@implementation TRFocusOnViewController
-(NSArray *)allFocusArr
{
    if (!_allFocusArr) {
        _allFocusArr = [TRFocusModel focusArray];
    }
    return _allFocusArr;
}

#pragma mark - UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allFocusArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TRCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    TRFocusModel *model = self.allFocusArr[indexPath.row];
    
    [cell.iconIV sd_setImageWithURL:[NSURL URLWithString:model.imageStr] placeholderImage:[UIImage imageNamed:@"分类"]];
    [cell.avatarIV sd_setImageWithURL:[NSURL URLWithString:model.avatarStr] placeholderImage:[UIImage imageNamed:@"分类"]];
    cell.titleLb.text = model.Hls_title;
    cell.viewLb.text = model.Hls_onlines;
    cell.nickLb.text = model.Hls_name;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    PlayController *pVC = [PlayController new];
    TRFocusModel *model = self.allFocusArr[indexPath.row];
    NSURL *url = [NSURL URLWithString:model.imageStr];
    pVC.Hls_title = model.Hls_title;
    pVC.Hls_imageURL = url;
    pVC.Hls_name = model.Hls_name;
    pVC.Hls_onlines = model.Hls_onlines;
    pVC.Hls_liveStr = model.Hls_liveStr;
    pVC.Hls_avatarURL = [NSURL URLWithString: model.avatarStr];
    [self presentViewController:pVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView beginHeaderRefresh];
    
    [Factory addBackItemToVC:self];
    self.title = @"我的关注";
    if (self.allFocusArr.count == 0) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"赶快去关注主播吧~~~";
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(0);
            make.centerY.equalTo(0);
            make.width.equalTo(200);
            make.height.equalTo(30);
        }];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [self.view addSubview:_collectionView];
      
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(0);
            
        }];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kBGColor;
        
        WK(weakSelf);
        [_collectionView addHeaderRefresh:^{
            
                [weakSelf.collectionView reloadData];
             
                [weakSelf.collectionView endHeaderRefresh];
           
        }];
        
        [_collectionView addBackFooterRefresh:^{
           
                [weakSelf.collectionView reloadData];
            
                [weakSelf.collectionView endFooterRefresh];

        }];
        
        [_collectionView registerClass:[TRCategoryCell class] forCellWithReuseIdentifier:@"Cell"];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.sectionInset = UIEdgeInsetsMake(kCellSpace, kCellSpace, kCellSpace, kCellSpace);
        _flowLayout.minimumLineSpacing = kCellSpace;
        _flowLayout.minimumInteritemSpacing = kCellSpace;
        CGFloat width = (kScreenW - (kCellNumPerLine + 1) * kCellSpace)/kCellNumPerLine;
        //        350 * 266
        CGFloat height = 266 * width / 350;
        _flowLayout.itemSize = CGSizeMake(width, height);
    }
    return _flowLayout;
}

@end
