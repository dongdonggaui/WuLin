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
@property (nonatomic) SKSpriteNode *buildingFoundation;
@property (nonatomic) CGPoint gridCenterOffset;

@property (nonatomic) SKSpriteNode *confirmNode;
@property (nonatomic) SKSpriteNode *cancelNode;

@property (nonatomic) BOOL isMoveGesture;
@property (nonatomic) BOOL touchedMoveArea;
@property (nonatomic) BOOL isAllreadyExist;

@end

static NSString *kWLCancelButtonNodeName = @"cancel_button";
static NSString *kWLConfirmButtonNodeName = @"confirm_button";

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
    self = [super initWithColor:[SKColor clearColor] size:CGSizeZero];
    if (self) {
        self.name = name;
        [self buildingGeneralInit];
    }
    
    return self;
}

#pragma mark - Setters & Getters
- (void)setPhysicalCoord:(CGPoint)physicalCoord
{
    _physicalCoord = physicalCoord;
}

#pragma mark - Override
- (void)moveToPointInGrid:(CGPoint)point
{
    [self setPhysicalCoord:point];
    CGPoint position = [WLGridManager screenPointAtGridX:point.x gridY:point.y];
    self.position = CGPointMake(position.x - self.gridCenterOffset.x, position.y - self.gridCenterOffset.y);
//    DLog(@"self.physical = %@, position = %@", NSStringFromCGPoint(point), NSStringFromCGPoint(self.position));
}

#pragma mark - Public methods
- (void)cancelBuild
{
    [self removeFromParent];
}

- (void)confirmBuild
{
    self.isBuilding = NO;
    self.isAllreadyExist = YES;
    self.buildingFoundation.alpha = 0;
    self.cancelNode.alpha = 0;
    self.confirmNode.alpha = 0;
}

- (void)becomeEditable
{
    self.isBuilding = YES;
    self.buildingFoundation.alpha = 1;
}

#pragma mark - Private methods
- (void)buildingGeneralInit
{
    self.isBuilding = YES;
    self.isAllreadyExist = NO;
    self.anchorPoint = CGPointZero;
    self.userInteractionEnabled = YES;
    JSTileMap *tile = [JSTileMap mapNamed:[NSString stringWithFormat:@"%@.tmx", self.name] withBaseZPosition:1 andZOrderModifier:0];
    if (tile) {
        // add building foundation
        self.buildingFoundation = [self generateBuildingFoundationWithGridSize:CGSizeMake(tile.mapSize.width - 1, tile.mapSize.height - 1)];
        [self addChild:self.buildingFoundation];
        
        tile.xScale = [WLGridManager sharedInstance].currentRate;
        tile.yScale = [WLGridManager sharedInstance].currentRate;
        tile.userInteractionEnabled = NO;
        [self addChild:tile];
        
        self.size = CGSizeMake(self.calculateAccumulatedFrame.size.width + self.calculateAccumulatedFrame.origin.x, self.calculateAccumulatedFrame.size.height + self.calculateAccumulatedFrame.origin.y);
        tile.position = CGPointMake(-tile.calculateAccumulatedFrame.origin.x + (self.size.width - tile.calculateAccumulatedFrame.size.width + tile.calculateAccumulatedFrame.origin.x) / 2, -tile.calculateAccumulatedFrame.origin.y);
        DLog(@"temple size = %@, tile size = %@", NSStringFromCGRect(self.calculateAccumulatedFrame), NSStringFromCGRect(tile.calculateAccumulatedFrame));
    }
    
    self.cancelNode = [SKSpriteNode spriteNodeWithImageNamed:@"building_cancel"];
    self.cancelNode.name = @"cancel_button";
    self.cancelNode.anchorPoint = CGPointZero;
    self.cancelNode.xScale = [WLGridManager sharedInstance].currentRate;
    self.cancelNode.yScale = [WLGridManager sharedInstance].currentRate;
    self.cancelNode.position = CGPointMake(0, self.size.height);
    [self addChild:self.cancelNode];
    
    self.confirmNode = [SKSpriteNode spriteNodeWithImageNamed:@"building_confirm"];
    self.confirmNode.name = @"confirm_button";
    self.confirmNode.anchorPoint = CGPointZero;
    self.confirmNode.xScale = [WLGridManager sharedInstance].currentRate;
    self.confirmNode.yScale = [WLGridManager sharedInstance].currentRate;
    self.confirmNode.position = CGPointMake(self.size.width - self.confirmNode.size.width, self.cancelNode.position.y);
    [self addChild:self.confirmNode];
}

- (SKSpriteNode *)generateBuildingFoundationWithGridSize:(CGSize)size
{
    SKSpriteNode *foundation = [SKSpriteNode node];
    foundation.anchorPoint = CGPointZero;
    int gridWidth = (int)size.width;
    int gridHeight = (int)size.height;
    
    // add first 由于无法提前计算出原点坐标的偏移量，故需要先添加再调整
    for (int y = 0; y < gridHeight; y++) {
        for (int x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"test_grid"];
            CGPoint position = [WLGridManager screenPointAtGridX:x gridY:y offset:CGPointZero]; /* 由于无法提前计算出远点坐标的偏移量，默认横纵坐标偏移量均为0 */
//            node.alpha = 0.05;
            node.xScale = [WLGridManager sharedInstance].currentRate;
            node.yScale = [WLGridManager sharedInstance].currentRate;
            node.anchorPoint = CGPointZero;
            node.position = position;
            node.name = [NSString stringWithFormat:@"(%d,%d)", x, y];
            
            [foundation addChild:node];
        }
    }
    // then adjust
    CGPoint delta = foundation.calculateAccumulatedFrame.origin;
    for (int y = 0; y < gridHeight; y++) {
        for (int x = 0; x < gridWidth; x++) {
            SKSpriteNode *node = (SKSpriteNode *)[foundation childNodeWithName:[NSString stringWithFormat:@"(%d,%d)", x, y]];
            node.position = CGPointMake(node.position.x - delta.x, node.position.y - delta.y);
            if (0 == x && 0 == y) {
                self.gridCenterOffset = node.position;
            }
        }
    }
    
    foundation.size = CGSizeMake(foundation.calculateAccumulatedFrame.size.width + foundation.calculateAccumulatedFrame.origin.x, foundation.calculateAccumulatedFrame.size.height + foundation.calculateAccumulatedFrame.origin.y);
    DLog(@"foundation size = %@, position = %@", NSStringFromCGRect(foundation.calculateAccumulatedFrame), NSStringFromCGPoint(foundation.position));
    
    return foundation;
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        self.isMoveGesture = NO;
        CGPoint touchedNodePoint = [touch locationInNode:self];
        SKNode *touchedNode = [self nodeAtPoint:touchedNodePoint];
        if ([touchedNode.name isEqualToString:kWLCancelButtonNodeName] || [touchedNode.name isEqualToString:kWLConfirmButtonNodeName]) {
            self.touchedMoveArea = NO;
        } else
        {
            self.touchedMoveArea = YES;
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        self.isMoveGesture = YES;
        if (!self.isBuilding) {
            SKSpriteNode *background = (SKSpriteNode *)self.parent.parent.parent;
            if ([background isKindOfClass:[WLLayerdNode class]]) {
                [background touchesMoved:touches withEvent:event];
            }
            return;
        }
        if (!self.touchedMoveArea) {
            return;
        }
        
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint grid = [WLGridManager gridAtScreenPoint:currentPoint];
        [self moveToPointInGrid:grid];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];

        // editing
        if (self.isBuilding) {
            if (touch.tapCount != 0) {
                
                if (self.isMoveGesture) {
                    return;
                }
                
                // single tap
                // tap cancel button or confirm button area
                if (![self touchedMoveArea]) {
                    CGPoint touchedPoint = [touch locationInNode:self];
                    SKNode *touchedNode = [self nodeAtPoint:touchedPoint];
                    if ([touchedNode.name isEqualToString:kWLCancelButtonNodeName]) {
                        [self cancelBuild];
                    } else if ([touchedNode.name isEqualToString:kWLConfirmButtonNodeName]) {
                        [self confirmBuild];
                    }
                }
            } else {
                // move touch up
                if (self.isMoveGesture) {
                    if (self.isAllreadyExist) {
                        [self confirmBuild];
                    }
                }
            }
        }
        // not editing
        else {
            if (touch.tapCount != 0) {
                // single tap
                if (!self.isMoveGesture) {
                    [self becomeEditable];
                }
            } 
        }
        
    }
}

@end

