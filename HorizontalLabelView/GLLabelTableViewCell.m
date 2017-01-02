//
//  GLLabelTableViewCell.m
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import "GLLabelTableViewCell.h"
#import "Masonry.h"
#import "GLLabelCollectionViewCell.h"
#import "GLCollectionView.h"
@interface GLLabelTableViewCell ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property(nonatomic , weak)GLCollectionView * collectionView;

@property(nonatomic , assign)NSInteger count;

@property(nonatomic , assign)CGFloat cellWidth;

@property(nonatomic , assign,getter=scrolling)BOOL  scroll;

@end

@implementation GLLabelTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _contentColor = [UIColor grayColor];
        _textColor = [UIColor whiteColor];
        _cellWidth = 80;
        _cellColor = [UIColor redColor];
        self.collectionView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
    if ([self.delegate respondsToSelector:@selector(labelCell:didSelected:)]) {
        [self.delegate labelCell:self didSelected:indexPath.row];
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _scroll = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _scroll = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate) {
        NSLog(@"%s --- YES",__FUNCTION__);
    }else{
        _scroll = NO;
        NSLog(@"%s --- NO ",__FUNCTION__);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.delegate respondsToSelector:@selector(labelCell:didScrollOffset:)]) {
        [self.delegate labelCell:self didScrollOffset:scrollView.contentOffset];
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

- (void)setPoint:(CGPoint)point{
    if (!self.scrolling) {
        [self.collectionView setContentOffset:point animated:NO];
    }
}

- (void)setPoint:(CGPoint)point delay:(BOOL)dalay{
    if (dalay) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.point = point;
        });
    }else{
        self.point = point;
    }
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
        GLCollectionView *collection = [[GLCollectionView alloc] initWithFrame:self.contentView.bounds collectionViewLayout:layout];
        collection.delegate = self;
        collection.dataSource = self;
        collection.showsHorizontalScrollIndicator = NO;
        collection.bounces = NO;
        collection.backgroundColor = _contentColor;
        [collection registerClass:[GLLabelCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.contentView addSubview:collection];
        [collection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.with.bottom.offset(0);
        }];
        
        _collectionView = collection;
    }
    return _collectionView;
}

@end
