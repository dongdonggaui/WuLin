//
//  WLNavigationViewNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WLNavigationNode.h"

@interface WLNavigationViewNode : SKSpriteNode

@property (nonatomic, weak) WLNavigationNode *navigationNode;
@property (nonatomic) WLBarButtonItemNode *rightBarButtonItem;

@end
