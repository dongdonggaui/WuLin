//
//  WLLayerdNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WLGrapicsUtilitites.h"

typedef enum : uint8_t {
	WLWorldLayerGround = 0,
    WLWorldLayerGrid,
	WLWorldLayerBelowCharacter,
	WLWorldLayerCharacter,
	WLWorldLayerAboveCharacter,
	WLWorldLayerTop,
	kWLWorldLayerCount
} WLWorldLayer;

@interface WLLayerdNode : SKSpriteNode

@property (nonatomic, readonly) SKNode *world;                  // root node to which all game renderables are attached
@property (nonatomic, readonly) NSMutableArray *layers;           // different layer nodes within the world

/* All sprites in the scene should be added through this method to ensure they are placed in the correct world layer. */
- (void)addNode:(SKNode *)node atWorldLayer:(WLWorldLayer)layer;

@end
