//
//  WLLayerdNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayerdNode.h"
#import "WLGridManager.h"

@interface WLLayerdNode ()

@property (nonatomic) SKNode *world;                    // root node to which all game renderables are attached
@property (nonatomic) NSMutableArray *layers;           // different layer nodes within the world
@property (nonatomic) CGFloat currentRate;              // use for pinch record current pinch rate

@end

@implementation WLLayerdNode

#pragma mark - Designated Init
+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLLayerdNode *game = [super spriteNodeWithImageNamed:name];
    if (game) {
        [game layeredNodeGeneralInit];
    }
    
    return game;
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLLayerdNode *game = [super spriteNodeWithColor:color size:size];
    if (game) {
        [game layeredNodeGeneralInit];
    }
    
    return game;
}

#pragma mark - Private methods
- (void)layeredNodeGeneralInit
{
    SKNode *world = [[SKNode alloc] init];
    world.name = @"world";
    self.world = world;
    NSMutableArray *layers = [NSMutableArray arrayWithCapacity:kWLWorldLayerCount];
    self.layers = layers;
    for (int i = 0; i < kWLWorldLayerCount; i++) {
        SKNode *layer = [[SKNode alloc] init];
        layer.zPosition = i - kWLWorldLayerCount;
        [world addChild:layer];
        [(NSMutableArray *)layers addObject:layer];
    }
    
    [self addChild:world];
    self.currentRate = 1;
}

#pragma mark - Public Methods
- (void)addNode:(SKNode *)node atWorldLayer:(WLWorldLayer)layer {
    SKNode *layerNode = self.layers[layer];
    [layerNode addChild:node];
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (2 == touches.count) {
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint previousPoint = [touch previousLocationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
        [self handlePanTranslation:translation limitX:YES limitY:YES];
    } else if (2 == touches.count) {
        NSArray *arr = [touches allObjects];
        UITouch *touch1 = [arr objectAtIndex:0];
        UITouch *touch2 = [arr objectAtIndex:1];
        CGPoint position1 = [touch1 locationInNode:self];
        CGPoint position2 = [touch2 locationInNode:self];
        CGPoint previousPosition1 = [touch1 previousLocationInNode:self];
        CGPoint previousPosition2 = [touch2 previousLocationInNode:self];
        
        // calculate pinch rate and execute pinch
        CGFloat distance = WLDistanceBetweenPoints(position1, position2);
        CGFloat preDistance = WLDistanceBetweenPoints(previousPosition1, previousPosition2);
        
        CGFloat rate = self.currentRate + (distance - preDistance) / preDistance;
        CGFloat minWidth = self.scene.size.width;
        CGFloat minHeight = self.scene.size.height;
        CGFloat minWidthRate = minWidth / 1312.f;
        CGFloat minHeightRate = minHeight / 672.f;
        rate = MIN(rate, 1.5);
        rate = MAX(rate, minWidthRate);
        rate = MAX(rate, minHeightRate);
        
        CGSize beforeSize = self.size;
        self.xScale = rate;
        self.yScale = rate;
        CGSize afterSize = self.size;
        
        self.currentRate = rate;
        
        // garuntee edge from out of screen
        CGFloat xDelta = (afterSize.width - beforeSize.width) / 2;
        CGFloat yDelta = (afterSize.height - beforeSize.height) / 2;
        CGPoint currentPosition = self.position;
        currentPosition.x -= xDelta;
        currentPosition.y -= yDelta;
        currentPosition.x = MIN(currentPosition.x, 0);
        currentPosition.x = MAX(currentPosition.x, self.scene.size.width - self.size.width);
        currentPosition.y = MIN(currentPosition.y, 0);
        currentPosition.y = MAX(currentPosition.y, self.scene.size.height - self.size.height);
        self.position = currentPosition;
        
        DLog(@"scale = %f, globelScale = %f", rate, [WLGridManager sharedInstance].currentRate);
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
