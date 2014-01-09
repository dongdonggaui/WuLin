//
//  WLMenPai.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMenPai.h"
#import "WLGridUtility.h"
#import "JSTileMap.h"

@implementation WLMenPai

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLMenPai *node = [super spriteNodeWithColor:color size:size];
    [node generalInit];
    
    return node;
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLMenPai *node = [super spriteNodeWithImageNamed:name];
    [node generalInit];
    
    return node;
}

#pragma mark - Private Methods
- (void)generalInit
{
    self.anchorPoint = CGPointZero;
    JSTileMap *tileMap = [JSTileMap mapNamed:@"isometric_grass_and_water.tmx" withBaseZPosition:1 andZOrderModifier:0];
    if (tileMap) {
//        tileMap.zPosition = 1;
        tileMap.xScale = 0.5;
        tileMap.yScale = 0.5;
        [self addNode:tileMap atWorldLayer:WLWorldLayerGround];
        self.size = tileMap.calculateAccumulatedFrame.size;
    }
//    [WLGridUtility generateTilesInNode:self withGridWidth:9 gridHeight:9];
//    [self hideGrid];
}

@end
