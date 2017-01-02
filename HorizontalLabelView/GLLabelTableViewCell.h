//
//  GLLabelTableViewCell.h
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLLabelTableViewCell;
@protocol GLLabelTableViewCellDelegate <NSObject>

- (void)labelCell:(GLLabelTableViewCell *)cell didScrollOffset:(CGPoint)contentOffset;

- (void)labelCell:(GLLabelTableViewCell *)cell didSelected:(NSInteger)index;

@end

@interface GLLabelTableViewCell : UITableViewCell

- (void)loadCount:(NSInteger)count width:(CGFloat)width;

@property(nonatomic , strong)NSArray * titleArray;

@property(nonatomic , assign)CGPoint point;

- (void)setPoint:(CGPoint)point delay:(BOOL)dalay;

@property(nonatomic , assign)id<GLLabelTableViewCellDelegate> delegate;

@property(nonatomic , strong)UIColor * cellColor;

@property(nonatomic , strong)UIColor * contentColor;

@property(nonatomic , strong)UIColor * textColor;

@end
