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
        node.userInteractionEnabled = YES;
        
        WLBarButtonItemNode *item = [WLBarButtonItemNode spriteNodeWithImageNamed:@"nav_close" delegate:node];
        item.name = @"nav_close";
        node.rightBarButtonItem = item;
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

@end
