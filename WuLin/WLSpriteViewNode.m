//
//  WLNavigationViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLSpriteViewNode.h"

const NSString *kWLNodeDidAddToParentNotification = @"kWLNodeDidAddToParentNotification";

@implementation WLSpriteViewNode

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLSpriteViewNode *node = [super spriteNodeWithColor:color size:size];
    if (node) {
        [node generallyInit];
    }
    
    return node;
}


#pragma mark - Private methods
- (void)generallyInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAddToParentNotification:) name:(NSString *)kWLNodeDidAddToParentNotification object:nil];
}

- (void)didReceiveAddToParentNotification:(NSNotification *)notification
{
    
}

@end
