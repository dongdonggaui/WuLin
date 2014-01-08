//
//  WLLayeredScene.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayeredScene.h"

const NSString *kWLPlayWindowKey = @"kWLPlayWindowKey";

@interface WLLayeredScene ()

@property (nonatomic) SKNode *playWindow;                    // root node to which all game renderables are attached
@property (nonatomic) NSMutableArray *layers;           // different layer nodes within the world

@end

@implementation WLLayeredScene

#pragma mark - Init
- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKNode *world = [[SKNode alloc] init];
        self.playWindow = world;
        [world setName:(NSString *)kWLPlayWindowKey];
        NSMutableArray *layers = [NSMutableArray arrayWithCapacity:kWLSceneLayerCount];
        self.layers = layers;
        for (int i = 0; i < kWLSceneLayerCount; i++) {
            SKNode *layer = [[SKNode alloc] init];
            layer.zPosition = i;
            [world addChild:layer];
            [(NSMutableArray *)layers addObject:layer];
        }
        
        [self addChild:world];
    }
    return self;
}

#pragma mark - Puclic Methods
- (void)addNode:(SKNode *)node atWorldLayer:(WLSceneLayer)layer {
    SKNode *layerNode = self.layers[layer];
    [layerNode addChild:node];
}

@end
