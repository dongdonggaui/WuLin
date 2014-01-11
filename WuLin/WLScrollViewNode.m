//
//  WLScrollViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLScrollViewNode.h"

@implementation WLScrollViewNode


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
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
        [self handlePanTranslation:translation];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
