//
//  GLCollectionView.m
//  RoomChooseDemo
//
//  Created by huang long on 16/12/30.
//  Copyright © 2016年 huang gu long. All rights reserved.
//

#import "GLCollectionView.h"

@implementation GLCollectionView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touch = YES;
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touch = NO;
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _touch = NO;
    [super touchesCancelled:touches withEvent:event];
}

@end
