//
//  WLNavigationBarNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLNavigationBarNode.h"

@implementation WLNavigationBarNode

+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture size:(CGSize)size
{
    WLNavigationBarNode *bar = [super spriteNodeWithTexture:texture size:size];
    if (bar) {
        bar.userInteractionEnabled = YES;
    }
    
    return bar;
}

@end
