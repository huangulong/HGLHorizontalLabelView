//
//  GLLabelCustomHeaderView.m
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import "GLLabelCustomHeaderView.h"
#import "Masonry.h"
#import "GLLabelCollectionViewCell.h"
#import "GLCollectionView.h"
@interface GLLabelCustomHeaderView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic , weak)GLCollectionView * collectionView;

@property(nonatomic , assign)NSInteger count;

@property(nonatomic , assign)CGFloat cellWidth;

@end

@implementation GLLabelCustomHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentColor = [UIColor grayColor];
        _textColor = [UIColor whiteColor];
        _cellWidth = 80;
        _cellColor = [UIColor redColor];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GLLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = self.cellColor;
    cell.titleLabel.textColor = self.textColor;
    if (indexPath.row < self.titleArray.count) {
        id m = [self.titleArray objectAtIndex:indexPath.row];
        if ([m isKindOfClass:[NSString class]]) {
            cell.titleLabel.text = m;
        }else if ([m isKindOfClass:[NSAttributedString class]]){
            cell.titleLabel.attributedText = m;
        }else{
            cell.titleLabel.text = @"";
        }
    }else{
        cell.titleLabel.text = @"";
    }
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.cellWidth, collectionView.frame.size.height - 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(labelCustomView:didSelected:)]) {
        [self.delegate labelCustomView:self didSelected:indexPath.row];
    }
}

- (void)scrollViewDidScroll:(GLCollectionView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(labelCustomView:didScrollOffset:)]) {
        [self.delegate labelCustomView:self didScrollOffset:scrollView.contentOffset];
    }
}

#pragma mark - public
- (void)loadCount:(NSInteger)count width:(CGFloat)width{
    _count = count;
    _cellWidth = width;
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    [self.collectionView reloadData];
}

- (void)setContentColor:(UIColor *)contentColor{
    _contentColor = contentColor;
    _collectionView.backgroundColor = contentColor;
}

#pragma mark - setter getter
- (GLCollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        GLCollectionView *collection = [[GLCollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        collection.delegate = self;
        collection.dataSource = self;
        collection.showsHorizontalScrollIndicator = NO;
        collection.bounces = NO;
        collection.backgroundColor = _contentColor;
        [collection registerClass:[GLLabelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self addSubview:collection];
        [collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.with.bottom.offset(0);
        }];
        
        _collectionView = collection;
    }
    return _collectionView;
}

- (void)setPoint:(CGPoint)point{
    self.collectionView.contentOffset = point;
}


@end
