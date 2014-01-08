//
//  WLMenPai.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMenPai.h"

@implementation WLMenPai

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLMenPai *node = [super spriteNodeWithColor:color size:size];
    node.anchorPoint = CGPointZero;
    
    return node;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint previousPoint = [touch previousLocationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
        CGPoint postion = CGPointMake(self.position.x + translation.x, self.position.y + translation.y);
        postion.x = MIN(postion.x , 0);
        postion.x = MAX(self.scene.size.width - self.size.width, postion.x);
        postion.y = MIN(postion.y , 0);
        postion.y = MAX(postion.y, self.scene.size.height - self.size.height);
        self.position = postion;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
