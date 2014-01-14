//
//  WLSelectorViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLSelectorViewNode.h"

@interface WLSelectorViewNode () <WLBarButtonItemNodeDelegate>

@end

@implementation WLSelectorViewNode

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLSelectorViewNode *node = [super spriteNodeWithColor:color size:size];
    if (node) {
        [node selectorGeneralInit];
    }
    
    return node;
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLSelectorViewNode *node = [super spriteNodeWithImageNamed:name];
    if (node) {
        [node selectorGeneralInit];
    }
    
    return node;
}

#pragma mark - bar button delegate
- (void)buttonItemDidTapped:(WLBarButtonItemNode *)buttonItem
{
    if ([buttonItem.name isEqualToString:@"nav_close"]) {
        [self.navigationNode dismiss];
    }
}

#pragma mark - Private methods
- (void)selectorGeneralInit
{
    self.userInteractionEnabled = YES;
    
    WLBarButtonItemNode *item = [WLBarButtonItemNode spriteNodeWithImageNamed:@"nav_close" delegate:self];
    item.name = @"nav_close";
    self.rightBarButtonItem = item;
}

@end
