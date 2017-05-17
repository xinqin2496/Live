//
//  TwoView.m
//  TRProject
//
//  Created by 郑文青 on 16/7/21.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "TwoView.h"
#import "TwoViewCell.h"
#import "TRCategoryViewModel.h"
@interface TwoView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) TRCategoryViewModel *categoryVM;


@end

@implementation TwoView
- (TRCategoryViewModel *)categoryVM {
    if(_categoryVM == nil) {
        _categoryVM = [[TRCategoryViewModel alloc] initWithSlug:@"beauty"];//使用全民星秀的排行
    }
    return _categoryVM;
}
-(instancetype)init
{
    self=[[[NSBundle mainBundle]loadNibNamed:@"TwoView" owner:nil options:nil] lastObject];
    
    if (self ) {
        
        _collectionView.delegate = self;
        _collectionView.dataSource =self;
    [_collectionView beginHeaderRefresh];
    [_collectionView addHeaderRefresh:^{
 
      [_categoryVM getDataWithRequestMode:RequestModeRefresh completionHandler:^(NSError *error) {
          if (!error) {
              [_collectionView reloadData];
             
          }
          
      }];
            [_collectionView endHeaderRefresh];
        }];
    }
    
    return self;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.categoryVM.rowNumber;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UINib *nib = [UINib nibWithNibName:@"TwoViewCell" bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:@"TwoViewCell"];
    TwoViewCell *cell = [[TwoViewCell alloc]init];
    
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"TwoViewCell"
                                                     forIndexPath:indexPath];
    [cell.iconIV sd_setImageWithURL:[self.categoryVM iconURLForRow:indexPath.row] placeholderImage:[UIImage imageNamed:@"分类"]];
    cell.titleLb.text = [self.categoryVM titleForRow:indexPath.row];
    cell.countLb.text = [self.categoryVM viewForRow:indexPath.row];
    cell.nameLb.text = [self.categoryVM nickForRow:indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenW, 80);
}
@end
