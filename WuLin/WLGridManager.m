//
//  WLGridManager.m
//  WuLin
//
//  Created by huangluyang on 14-1-13.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridManager.h"
#import "WLLayerdNode.h"

@implementation WLGridManager

+ (instancetype)sharedInstance
{
    static WLGridManager *sharedGridManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedGridManager) {
            sharedGridManager = [[WLGridManager alloc] init];
        }
    });
    
    return sharedGridManager;
}

+ (CGPoint)convertCoordinateToSceneWitGridX:(NSInteger)x
                                      gridY:(NSInteger)y
{
    WLGridManager *manager = [self sharedInstance];
    CGFloat zoomRate = manager.currentRate;
    CGPoint basePoint = manager.basePoint;
    CGFloat width = manager.tileWidth;
    CGFloat height = manager.tileHeight;
    
    return CGPointMake(floorf(basePoint.x + width * zoomRate / 2 * (x - y)), floorf(basePoint.y - height * zoomRate / 2 * (x + y)));
}

+ (void)generateTilesInNode:(WLLayerdNode *)theNode
              withGridWidth:(NSInteger)gridWidth
                 gridHeight:(NSInteger)gridHeight
{
    for (NSInteger y = 0; y < gridHeight; y++) {
        for (NSInteger x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_grid"];
            CGPoint position =
            [self convertCoordinateToSceneWitGridX:x gridY:y];
//            node.alpha = 0.05;
            node.anchorPoint = CGPointZero;
            node.position = position;
            if (0 == x && 0 == y) {
                DLog(@"(0, 0) = %@", NSStringFromCGPoint(position));
            }
//            SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"宋体"];
//            label.text = NSStringFromCGPoint(CGPointMake(x, y));
//            label.fontSize = 10;
//            label.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
//            label.position = CGPointMake((node.size.width) / 2, (node.size.height) / 2);
//            [node addChild:label];
            [theNode addNode:node atWorldLayer:WLWorldLayerGrid];
        }
    }
}

@end
