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

@class WLSpriteViewNode;

@interface WLNavigationNode : SKSpriteNode

@property (nonatomic) WLNavigationBarNode * navigationBar;
@property (nonatomic) WLBarButtonItemNode * backItem;
@property (nonatomic) WLBarButtonItemNode * rightBarButtonItem;
@property (nonatomic, readonly) WLSpriteViewNode *topNode;

- (instancetype)initWithRootNode:(WLSpriteViewNode *)rootNode size:(CGSize)size;
- (void)pushNode:(WLSpriteViewNode *)node;
- (void)popNode;
- (void)show;
- (void)dismiss;

@end
