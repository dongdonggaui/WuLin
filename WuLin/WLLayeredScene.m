//
//  WLLayeredScene.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayeredScene.h"

const NSString *kWLWorldKey = @"kWLWorldKey";

@interface WLLayeredScene ()

@property (nonatomic) SKNode * screen;
@property (nonatomic) NSMutableArray * sceneLayers;

- (void)addNode:(SKNode *)node atSceneLayer:(WLSceneLayer)sceneLayer;

@end

@implementation WLLayeredScene

#pragma mark - Init
- (instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKNode *screen = [[SKNode alloc] init];
        screen.name = @"screen";
        self.screen = screen;
        NSMutableArray *sceneLayers = [NSMutableArray arrayWithCapacity:kWLSceneLayerCount];
        self.sceneLayers = sceneLayers;
        for (int i = 0; i < kWLSceneLayerCount; i++) {
            SKNode *layer = [[SKNode alloc] init];
            layer.zPosition = i;
            [screen addChild:layer];
            [sceneLayers addObject:layer];
        }
        [self addChild:screen];
    }
    return self;
}

#pragma mark - Puclic Methods

- (void)addNode:(SKNode *)node atSceneLayer:(WLSceneLayer)sceneLayer
{
    SKNode *layerNode = self.sceneLayers[sceneLayer];
    [layerNode addChild:node];
}


@end
