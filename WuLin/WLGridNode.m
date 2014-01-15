//
//  WLGridNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridNode.h"

@interface WLGridNode ()

@property (nonatomic, getter = isShowGrid) BOOL showGrid;

@end

@implementation WLGridNode

#pragma mark - Setters & Getters
- (void)setShowGrid:(BOOL)showGrid
{
//    _showGrid = showGrid;
//    SKNode *node = self.layers[WLWorldLayerGrid];
//    node.hidden = !showGrid;
}

#pragma mark - Public Methods
- (void)showGrid
{
    self.showGrid = YES;
}

- (void)hideGrid
{
    self.showGrid = NO;
}

#pragma mark - To be override
- (void)moveToPointInGrid:(CGPoint)point
{
}



@end
