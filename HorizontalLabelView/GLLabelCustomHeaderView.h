//
//  GLLabelCustomHeaderView.h
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GLLabelCustomHeaderView;
@protocol GLLabelCustomHeaderViewViewDelegate <NSObject>

- (void)labelCustomView:(GLLabelCustomHeaderView *)headerView didScrollOffset:(CGPoint)contentOffset;

- (void)labelCustomView:(GLLabelCustomHeaderView *)headerView didSelected:(NSInteger)index;

@end

@interface GLLabelCustomHeaderView : UIView

- (void)loadCount:(NSInteger)count width:(CGFloat)width;

@property(nonatomic , strong)NSArray * titleArray;

@property(nonatomic , assign)CGPoint point;

@property(nonatomic , assign)id<GLLabelCustomHeaderViewViewDelegate> delegate;

@property(nonatomic , strong)UIColor * cellColor;

@property(nonatomic , strong)UIColor * textColor;

@property(nonatomic , strong)UIColor * contentColor;

@end
