//
//  WLScrollViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLScrollViewNode.h"

@implementation WLScrollViewNode

#pragma mark - Designate inits
+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLScrollViewNode *node = [super spriteNodeWithColor:color size:size];
    if (node) {
        [node scrollGeneralInit];
    }
    
    return node;
}

#pragma mark - Private methods
- (void)scrollGeneralInit
{
    self.anchorPoint = CGPointZero;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (2 == touches.count) {
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint previousPoint = [touch previousLocationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, 0);
        [self handlePanTranslation:translation limitX:YES limitY:NO];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
