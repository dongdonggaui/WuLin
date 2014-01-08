//
//  WLGridNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridNode.h"

const float kGridWidth = 64.f;
const float kGridHeight = 32.f;

@implementation WLGridNode

#pragma mark - Public Methods
- (CGPoint)convertCoordinateToScene:(CGPoint)tileCoordinate offset:(CGPoint)offset
{
    NSLog(@"self.scale = %f", self.parent.parent.parent.xScale);
    return CGPointMake((kGridWidth * self.parent.parent.parent.xScale / 2 * (tileCoordinate.x - tileCoordinate.y + 1) + offset.x), (kGridHeight * self.parent.parent.parent.yScale / 2 * (tileCoordinate.x + tileCoordinate.y + 1) + offset.y));
}

#pragma mark - To be override
- (void)moveToPointInMathCoord:(CGPoint)point
{
    
}

- (void)generateTilesWithGridWidth:(NSInteger)gridWidth gridHeight:(NSInteger)gridHeight
{
    for (NSInteger y = 0; y < gridHeight; y++) {
        for (NSInteger x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_grid"];
            CGPoint position = [self convertCoordinateToScene:CGPointMake(x, y) offset:CGPointMake((self.size.width - kGridWidth) / 2, 0)];
            node.alpha = 0.3;
            node.position = CGPointMake(position.x , self.size.height - position.y);
//            [self addNode:node atWorldLayer:WLWorldLayerBelowCharacter];
        }
    }
}

@end
