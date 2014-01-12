//
//  WLNavigationViewNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WLNavigationNode.h"

extern const NSString *kWLNodeDidAddToParentNotification;

@interface WLSpriteViewNode : SKSpriteNode

@property (nonatomic, weak) WLNavigationNode *navigationNode;
@property (nonatomic) WLBarButtonItemNode *rightBarButtonItem;
@property (nonatomic) NSString * title;

/**
 @brief 添加到父 node 回调，抽象方法，需重写
 */
- (void)didReceiveAddToParentNotification:(NSNotification *)notification;

@end
