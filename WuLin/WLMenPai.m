//
//  WLMenPai.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMenPai.h"
#import "WLGridUtility.h"

@implementation WLMenPai

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLMenPai *node = [super spriteNodeWithColor:color size:size];
    [node generalInit];
    
    return node;
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLMenPai *node = [super spriteNodeWithImageNamed:name];
    [node generalInit];
    
    return node;
}

#pragma mark - Private Methods
- (void)generalInit
{
    self.anchorPoint = CGPointZero;
    [WLGridUtility generateTilesInNode:self withGridWidth:9 gridHeight:9];
    [self hideGrid];
}

@end
