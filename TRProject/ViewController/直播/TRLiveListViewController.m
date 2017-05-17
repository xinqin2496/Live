//
//  TRLiveListViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRLiveListViewController.h"
#import "TRLiveListViewModel.h"
#import "TRCategoryCell.h"
#import "TRSearchViewController.h"
#import "PlayController.h"

#define kCellSpace          8
#define kCellNumPerLine     2

@interface TRLiveListViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) TRLiveListViewModel *liveListVM;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@end

@implementation TRLiveListViewController

#pragma mark - UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.liveListVM.rowNumber;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TRCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell.iconIV sd_setImageWithURL:[self.liveListVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"分类"]];
    [cell.avatarIV sd_setImageWithURL:[self.liveListVM avatarURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"分类"]];
    cell.titleLb.text = [self.liveListVM titleForRow:indexPath.row];
    cell.viewLb.text = [self.liveListVM viewForRow:indexPath.row];
    cell.nickLb.text = [self.liveListVM nickForRow:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    PlayController *playerVc = [PlayController new];
    
    playerVc.Hls_imageURL = [self.liveListVM iconURLForRow:indexPath.row];
    playerVc.Hls_liveStr = [[self.liveListVM videoURLForRow:indexPath.row]absoluteString];
    playerVc.Hls_onlines = [self.liveListVM viewForRow:indexPath.row];
    playerVc.Hls_name = [self.liveListVM nickForRow:indexPath.row];
    playerVc.Hls_title = [self.liveListVM titleForRow:indexPath.row];
    playerVc.Hls_avatarURL = [self.liveListVM avatarURLForRow:indexPath.row];
    
    [self presentViewController:playerVc animated:YES completion:nil];
   
}


#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.navigationBar setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.shadowImage =[UIImage new];
    
    [self.collectionView beginHeaderRefresh];
    [Factory addSearchItemToVC:self clickHandler:^{
        TRSearchViewController *vc = [TRSearchViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Lazy Load
- (UICollectionView *)collectionView {
    if(_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(0);
            make.left.bottom.right.equalTo(0);
            make.top.equalTo(0);
        }];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = kBGColor;
        WK(weakSelf);
        [_collectionView addHeaderRefresh:^{
            [weakSelf.liveListVM getDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
                if (!error) {
                    [weakSelf.collectionView reloadData];
                }else{
                    [weakSelf.view showWarning:error.localizedDescription];
                }
                if (weakSelf.liveListVM.page + 1 >= weakSelf.liveListVM.pageCount) {
                    [weakSelf.collectionView endFooterRefreshWithNoMoreData];
                }
                [weakSelf.collectionView endHeaderRefresh];
            }];
        }];
        
        [_collectionView addBackFooterRefresh:^{
            [weakSelf.liveListVM getDataWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
                if (!error) {
                    [weakSelf.collectionView reloadData];
                }else{
                    [weakSelf.view showWarning:error.localizedDescription];
                }
                if (weakSelf.liveListVM.page + 1 >= weakSelf.liveListVM.pageCount) {
                    [weakSelf.collectionView endFooterRefreshWithNoMoreData];
                }else{
                    [weakSelf.collectionView endFooterRefresh];
                }
                
            }];
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


- (TRLiveListViewModel *)liveListVM {
    if(_liveListVM == nil) {
        _liveListVM = [[TRLiveListViewModel alloc] init];
    }
    return _liveListVM;
}

@end
