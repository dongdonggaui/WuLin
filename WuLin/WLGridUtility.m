//
//  WLGridUtility.m
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridUtility.h"
#import "WLLayerdNode.h"

const float kGridWidth = 64.f;
const float kGridHeight = 32.f;

@implementation WLGridUtility

+ (CGPoint)convertCoordinateToScene:(CGPoint)tileCoordinate withZoomRate:(CGFloat)zoomRate offset:(CGPoint)offset
{
    return CGPointMake((kGridWidth * zoomRate / 2 * (tileCoordinate.x - tileCoordinate.y + 1) + offset.x), (kGridHeight * zoomRate / 2 * (tileCoordinate.x + tileCoordinate.y + 1) + offset.y));
}

+ (void)generateTilesInNode:(WLLayerdNode *)theNode withGridWidth:(NSInteger)gridWidth gridHeight:(NSInteger)gridHeight
{
    for (NSInteger y = -gridHeight; y < gridHeight; y++) {
        for (NSInteger x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_grid"];
            CGPoint position = [self convertCoordinateToScene:CGPointMake(x, y) withZoomRate:1 offset:CGPointZero];
            node.alpha = 0.3;
            node.position = CGPointMake(position.x , theNode.scene.size.height - position.y);
            SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"宋体"];
            label.text = NSStringFromCGPoint(CGPointMake(x, y));
            label.fontSize = 12;
            label.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
            [node addChild:label];
            [theNode addNode:node atWorldLayer:WLWorldLayerGrid];
        }
    }
}

@end
