//
//  GLLabelTableHeaderView.h
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GLLabelTableHeaderView;
@protocol GLLabelTableHeaderViewDelegate <NSObject>

- (void)labelHeaderView:(GLLabelTableHeaderView *)headerView didScrollOffset:(CGPoint)contentOffset;

- (void)labelHeaderView:(GLLabelTableHeaderView *)headerView didSelected:(NSInteger)index;

@end

@interface GLLabelTableHeaderView : UITableViewHeaderFooterView

- (void)loadCount:(NSInteger)count width:(CGFloat)width;

@property(nonatomic , strong)NSArray * titleArray;

@property(nonatomic , assign)CGPoint point;

@property(nonatomic , assign)id<GLLabelTableHeaderViewDelegate> delegate;

@property(nonatomic , strong)UIColor * cellColor;

@property(nonatomic , strong)UIColor * textColor;

@property(nonatomic , strong)UIColor * contentColor;

@end
