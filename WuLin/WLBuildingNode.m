//
//  WLBuildingNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLBuildingNode.h"
#import "WLGridUtility.h"
#import "JSTileMap.h"

extern const float kGridWidth;
extern const float kGridHeight;

@interface WLBuildingNode ()

@property (nonatomic) CGPoint physicalCoord;
@property (nonatomic) BOOL isBuilding;

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
            node.position = CGPointMake((i+j) * kGridWidth / 2, (i-j) * kGridHeight / 2);
            [building addChild:node];
        }
    }
    building.isBuilding = YES;
    
    return building;
}

- (instancetype)initWithName:(NSString *)name
{
    self = [super initWithColor:[SKColor clearColor] size:CGSizeZero];
    if (self) {
        self.name = name;
        self.userInteractionEnabled = YES;
        JSTileMap *tile = [JSTileMap mapNamed:[NSString stringWithFormat:@"%@.tmx", name] withBaseZPosition:1 andZOrderModifier:0];
        if (tile) {
            [self addChild:tile];
            tile.userInteractionEnabled = NO;
            self.size = self.calculateAccumulatedFrame.size;
        }
    }
    
    return self;
}

#pragma mark - Setters & Getters
- (void)setPhysicalCoord:(CGPoint)physicalCoord
{
    _physicalCoord = physicalCoord;
    SKSpriteNode *parentNode = (SKSpriteNode *)self.parent.parent.parent;
    CGPoint position = [WLGridUtility convertCoordinateToScene:physicalCoord withZoomRate:self.xScale offset:CGPointMake(0, 0)];
    self.position = CGPointMake(position.x, parentNode.size.height - position.y);
}

#pragma mark - Override
- (void)moveToPointInMathCoord:(CGPoint)point
{
    [self setPhysicalCoord:point];
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
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - self.position.x, currentPoint.y - self.position.y);
        CGPoint physicalCoord = self.physicalCoord;
        if (translation.x > 32) {
            physicalCoord.x++;
        } else if (translation.x < -32) {
            physicalCoord.x--;
        }
        if (translation.y > 16) {
            physicalCoord.y--;
        } else if (translation.y < -16) {
            physicalCoord.y++;
        }
        if (self.physicalCoord.x != physicalCoord.x || self.physicalCoord.y != physicalCoord.y) {
            [self moveToPointInMathCoord:physicalCoord];
        }
    }
}

@end
