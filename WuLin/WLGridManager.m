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

+ (void)generateTilesInNode:(WLLayerdNode *)theNode
              withGridWidth:(NSInteger)gridWidth
                 gridHeight:(NSInteger)gridHeight
{
    for (NSInteger y = 0; y < gridHeight; y++) {
        for (NSInteger x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_grid"];
            CGPoint position = [self screenPointAtGridX:x gridY:y currentRate:[WLGridManager sharedInstance].currentRate width:64.f height:32.f];
//            node.alpha = 0.05;
            node.xScale = [WLGridManager sharedInstance].currentRate;
            node.yScale = [WLGridManager sharedInstance].currentRate;
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

+ (CGPoint)screenPointAtGridX:(NSInteger)x gridY:(NSInteger)y
{
    WLGridManager *manager = [self sharedInstance];
    CGFloat zoomRate = manager.currentRate;
    CGFloat width = manager.tileWidth;
    CGFloat height = manager.tileHeight;
    
    return [self screenPointAtGridX:x gridY:y currentRate:zoomRate width:width height:height];
}

+ (CGPoint)gridAtScreenPoint:(CGPoint)point
{
    WLGridManager *manager = [self sharedInstance];
    CGFloat zoomRate = manager.currentRate;
    CGPoint basePoint = manager.basePoint;
    CGFloat width = manager.tileWidth * zoomRate;
    CGFloat height = manager.tileHeight * zoomRate;
    
    return CGPointMake(floorf((point.x - basePoint.x) / width + (basePoint.y - point.y) / height), floorf((basePoint.y - point.y) / height - (point.x - basePoint.x) / width));
}

#pragma mark - Private methods
+ (CGPoint)screenPointAtGridX:(NSInteger)x
                        gridY:(NSInteger)y
                  currentRate:(CGFloat)rate
                        width:(CGFloat)width
                       height:(CGFloat)height
{
    WLGridManager *manager = [self sharedInstance];
    CGPoint basePoint = manager.basePoint;
    
    return CGPointMake(floorf(basePoint.x + width * rate / 2 * (x - y)), floorf(basePoint.y - height * rate / 2 * (x + y)));
}

@end
