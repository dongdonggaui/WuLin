//
//  WLBuildingNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLBuildingNode.h"
#import "WLGridManager.h"
#import "JSTileMap.h"

@interface WLBuildingNode ()

@property (nonatomic) CGPoint physicalCoord;
@property (nonatomic) BOOL isBuilding;
@property (nonatomic) CGPoint previousPoint;

@end

@implementation WLBuildingNode

#pragma mark - Desigated Init
+ (instancetype)buildingWithShadowImageName:(NSString *)imageName xTileCount:(int)xTileCount yTileCount:(int)yTileCount
{
    if (0 == xTileCount || 0 == yTileCount) {
        return nil;
    }
    
    WLBuildingNode *building = [[WLBuildingNode alloc] init];
    building.anchorPoint = CGPointZero;
    
    for (int i = xTileCount - 1; i >= 0; i--) {
        for (int j = 0; j < yTileCount; j++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_restroom"];
            node.position = CGPointMake((i+j) * 64.f / 2, (i-j) * 32.f / 2);
            [building addChild:node];
        }
    }
    building.isBuilding = YES;
    
    return building;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super initWithColor:[SKColor blueColor] size:CGSizeZero];
    if (self) {
        self.anchorPoint = CGPointZero;
        self.name = name;
        self.userInteractionEnabled = YES;
        JSTileMap *tile = [JSTileMap mapNamed:[NSString stringWithFormat:@"%@.tmx", name] withBaseZPosition:1 andZOrderModifier:0];
        if (tile) {
            tile.xScale = 0.5;
            tile.yScale = 0.5;
            tile.position = CGPointMake(0, -tile.calculateAccumulatedFrame.origin.y); /* 可理解为tile的anchor为(0,0) */
            [self addChild:tile];
            tile.userInteractionEnabled = NO;
            self.size = self.calculateAccumulatedFrame.size;
            DLog(@"temple size = %@, tile size = %@", NSStringFromCGSize(self.size), NSStringFromCGRect(tile.calculateAccumulatedFrame));
        }
    }
    
    return self;
}

#pragma mark - Setters & Getters
- (void)setPhysicalCoord:(CGPoint)physicalCoord
{
    _physicalCoord = physicalCoord;
//    SKSpriteNode *parentNode = (SKSpriteNode *)self.parent.parent.parent;
    CGPoint position = [WLGridManager screenPointAtGridX:physicalCoord.x gridY:physicalCoord.y];
    self.position = position;
}

#pragma mark - Override
- (void)moveToPointInMathCoord:(CGPoint)point
{
    [self setPhysicalCoord:point];
    DLog(@"self.physical = %@, position = %@", NSStringFromCGPoint(point), NSStringFromCGPoint(self.position));
}

#pragma mark - To be override
- (void)cancelBuild
{
    [self removeFromParent];
}
- (void)cofrimBuild
{
    self.isBuilding = NO;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        self.previousPoint = [touch locationInNode:self.parent];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint grid = [WLGridManager gridAtScreenPoint:currentPoint];
        [self moveToPointInMathCoord:grid];
    }
}

@end
