//
//  WLLayerdNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayerdNode.h"

@interface WLLayerdNode ()

@property (nonatomic) SKNode *world;                    // root node to which all game renderables are attached
@property (nonatomic) NSMutableArray *layers;           // different layer nodes within the world
@property (nonatomic) NSInteger gridWidth;
@property (nonatomic) NSInteger gridHeight;

@end

@implementation WLLayerdNode

#pragma mark - Designated Init
+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLLayerdNode *game = [super spriteNodeWithImageNamed:name];
    SKNode *world = [[SKNode alloc] init];
    [world setName:@"world"];
    game.world = world;
    NSMutableArray *layers = [NSMutableArray arrayWithCapacity:kWLWorldLayerCount];
    game.layers = layers;
    for (int i = 0; i < kWLWorldLayerCount; i++) {
        SKNode *layer = [[SKNode alloc] init];
        layer.zPosition = i;
        [world addChild:layer];
        [(NSMutableArray *)layers addObject:layer];
    }
    
    [game addChild:world];
    
    game.gridWidth = 9;
    game.gridHeight = 9;
    
    return game;
}

#pragma mark - Public Methods
- (void)addNode:(SKNode *)node atWorldLayer:(WLWorldLayer)layer {
    SKNode *layerNode = self.layers[layer];
    [layerNode addChild:node];
}

@end
