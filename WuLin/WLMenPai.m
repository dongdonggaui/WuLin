//
//  WLMenPai.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMenPai.h"
#import "WLGridManager.h"
#import "JSTileMap.h"

@interface WLMenPai ()

@end

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
    JSTileMap *tileMap = [JSTileMap mapNamed:@"test_ground.tmx" withBaseZPosition:1 andZOrderModifier:0];
    if (tileMap) {
        tileMap.xScale = 0.5;
        tileMap.yScale = 0.5;
        [self addNode:tileMap atWorldLayer:WLWorldLayerBelowGrid];
        tileMap.position = CGPointMake(32, 16);
        self.size = CGSizeMake(tileMap.calculateAccumulatedFrame.size.width + 32, tileMap.calculateAccumulatedFrame.size.height + 16);
        self.position = CGPointMake((self.scene.size.width - self.size.width) / 4, (self.scene.size.height - self.size.height) / 4);
        
        // initial global parameter {1, 0}, position = {656, 624}
        [WLGridManager sharedInstance].currentRate = 0.5;
        [WLGridManager sharedInstance].tileWidth   = tileMap.tileSize.width;
        [WLGridManager sharedInstance].tileHeight  = tileMap.tileSize.height;
        [WLGridManager sharedInstance].xGridCount  = tileMap.mapSize.width;
        [WLGridManager sharedInstance].yGridCount  = tileMap.mapSize.height;
        [WLGridManager sharedInstance].basePoint   = CGPointMake((self.size.width - tileMap.tileSize.width * 0.5) / 2, self.size.height - tileMap.tileSize.height * 0.5 - tileMap.position.y - 8);
        // generate grid
        [WLGridManager generateTilesInNode:self
                             withGridWidth:tileMap.mapSize.width
                                gridHeight:tileMap.mapSize.height];
        
        DLog(@"map.size = %@, tilesize = %@", NSStringFromCGSize(self.size), NSStringFromCGSize(tileMap.tileSize));
    }
}

@end
