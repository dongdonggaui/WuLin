//
//  WLNavigationNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WLBarButtonItemNode.h"
#import "WLNavigationBarNode.h"

@class WLNavigationViewNode;

@interface WLNavigationNode : SKSpriteNode

@property (nonatomic) WLNavigationBarNode * navigationBar;
@property (nonatomic) WLBarButtonItemNode * backItem;
@property (nonatomic) WLBarButtonItemNode * rightBarButtonItem;
@property (nonatomic, readonly) WLNavigationViewNode *topNode;

- (instancetype)initWithRootNode:(WLNavigationViewNode *)rootNode size:(CGSize)size;
- (void)pushNode:(SKSpriteNode *)node;
- (void)popNode;

@end
