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
    WLSpriteViewNode *node = [[self alloc] initWithColor:color size:size];
    if (node) {
        
    }
    
    return node;
}

- (instancetype)initWithColor:(UIColor *)color size:(CGSize)size
{
    self = [super initWithColor:color size:size];
    if (self) {
        [self spriteViewGenerallyInit];
    }
    
    return self;
}

#pragma mark - Private methods
- (void)spriteViewGenerallyInit
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveAddToParentNotification:) name:(NSString *)kWLNodeDidAddToParentNotification object:nil];
}

- (void)didReceiveAddToParentNotification:(NSNotification *)notification
{
    
}

@end
