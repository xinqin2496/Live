//
//  TRCategoriesViewController.m
//  TRProject
//
//  Created by jiyingxin on 16/3/8.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TRCategoriesViewController.h"
#import "TRCategoriesViewModel.h"
#import "TRCategoriesCell.h"
#import "TRCategoryViewController.h"
#import "TRSearchViewController.h"

#define kCellSpace          8
#define kCellNumPerLine     3

@interface TRCategoriesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic) TRCategoriesViewModel *categoriesVM;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UICollectionViewFlowLayout *flowLayout;
@end

@implementation TRCategoriesViewController
#pragma mark - UICollectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.categoriesVM.rowNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TRCategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.nameLb.text = [self.categoriesVM titleForRow:indexPath.row];
    [cell.iconIV sd_setImageWithURL:[self.categoriesVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"分类"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TRCategoryViewController *vc = [[TRCategoryViewController alloc] initWithSlug:[self.categoriesVM slugForRow:indexPath.row] categoryName:[self.categoriesVM categoryNameForRow:indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kBGColor;
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
- (TRCategoriesViewModel *)categoriesVM {
    if(_categoriesVM == nil) {
        _categoriesVM = [[TRCategoriesViewModel alloc] init];
    }
    return _categoriesVM;
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
            [weakSelf.categoriesVM getDataWithRequestMode:RequestModeMore completionHandler:^(NSError *error) {
                if (!error) {
                    [weakSelf.collectionView reloadData];
                }else{
                    [weakSelf.view showWarning:error.localizedDescription];
                }
                [weakSelf.collectionView endHeaderRefresh];
            }];
        }];
        [_collectionView registerClass:[TRCategoriesCell class] forCellWithReuseIdentifier:@"Cell"];
        _collectionView.showsVerticalScrollIndicator = NO;
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
        //        23 * 38
        CGFloat height = 38 * width / 23;
        _flowLayout.itemSize = CGSizeMake(width, height);
    }
    return _flowLayout;
}

@end
