//
//  WLBarButtonItemNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class WLBarButtonItemNode;

@protocol WLBarButtonItemNodeDelegate <NSObject>

@optional
- (void)buttonItemDidTapped:(WLBarButtonItemNode *)buttonItem;

@end

@interface WLBarButtonItemNode : SKSpriteNode

@property (nonatomic, readonly) id<WLBarButtonItemNodeDelegate> delegate;

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name delegate:(id<WLBarButtonItemNodeDelegate>)delegate;

@end
