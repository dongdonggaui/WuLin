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
        node.rightBarButtonItem = item;
    }
    
    return node;
}

#pragma mark - bar button delegate
- (void)buttonItemDidTapped:(WLBarButtonItemNode *)buttonItem
{
    SKAction *action = [SKAction moveByX:0 y:-self.navigationNode.size.height duration:0.1];
    SKAction *complete = [SKAction runBlock:^{
        [self.navigationNode removeFromParent];
    }];
    [self.navigationNode runAction:[SKAction sequence:@[action, complete]]];
}

@end
