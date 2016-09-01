//
//  ZRPictureController.m
//  涂鸦
//
//  Created by Ryan on 15/10/28.
//  Copyright © 2015年 Ryan. All rights reserved.
//

#import "ZRPictureController.h"

#define PHOTO @"Photo"


@interface ZRPictureController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/** uicollectionView */
@property (nonatomic, weak) UICollectionView  *collectionView;

/** 图片 */
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation ZRPictureController

- (NSMutableArray *)photos
{
    if (!_photos) {
        _photos = [[NSMutableArray alloc] init];
    }
    return _photos;
}

- (void)viewDidLoad
{
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.scrollEnabled = YES;
    collectionView.pagingEnabled = YES;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:PHOTO];
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO forIndexPath:indexPath];
   
//    cell
    
    return cell;
}


@end
