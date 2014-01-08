//
//  WLLayeredScene.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : uint8_t {
	WLSceneLayerGame = 0,
    WLSceneLayerHUD,
	kWLSceneLayerCount
} WLSceneLayer;

@interface WLLayeredScene : SKScene

@property (nonatomic, readonly) SKNode *playWindow;                  // root node to which all game renderables are attached

/* All sprites in the scene should be added through this method to ensure they are placed in the correct world layer. */
- (void)addNode:(SKNode *)node atWorldLayer:(WLSceneLayer)layer;

@end
