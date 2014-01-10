//
//  WLLayerdNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayerdNode.h"

@interface WLLayerdNode ()

@property (nonatomic) SKNode *world;                    // root node to which all game renderables are attached
@property (nonatomic) NSMutableArray *layers;           // different layer nodes within the world
@property (nonatomic) CGFloat velocity;                 // use for pinch calculate rate
@property (nonatomic) CGFloat currentRate;              // use for pinch record current pinch rate
@property (nonatomic) CGPoint pinchCenter;              // use for pinch keep center

@end

@implementation WLLayerdNode

#pragma mark - Designated Init
+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLLayerdNode *game = [super spriteNodeWithImageNamed:name];
    SKNode *world = [[SKNode alloc] init];
    [world setName:@"world"];
    game.world = world;
    NSMutableArray *layers = [NSMutableArray arrayWithCapacity:kWLWorldLayerCount];
    game.layers = layers;
    for (int i = 0; i < kWLWorldLayerCount; i++) {
        SKNode *layer = [[SKNode alloc] init];
        layer.zPosition = i - kWLWorldLayerCount;
        [world addChild:layer];
        [(NSMutableArray *)layers addObject:layer];
    }
    
    [game addChild:world];
    
    return game;
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLLayerdNode *game = [super spriteNodeWithColor:color size:size];
    SKNode *world = [[SKNode alloc] init];
    [world setName:@"world"];
    game.world = world;
    NSMutableArray *layers = [NSMutableArray arrayWithCapacity:kWLWorldLayerCount];
    game.layers = layers;
    for (int i = 0; i < kWLWorldLayerCount; i++) {
        SKNode *layer = [[SKNode alloc] init];
        layer.zPosition = i - kWLWorldLayerCount;
        [world addChild:layer];
        [(NSMutableArray *)layers addObject:layer];
    }
    
    [game addChild:world];
    
    return game;
}

#pragma mark - Public Methods
- (void)addNode:(SKNode *)node atWorldLayer:(WLWorldLayer)layer {
    SKNode *layerNode = self.layers[layer];
    [layerNode addChild:node];
}


#pragma mark - Private Methods
- (void)handlePanTranslation:(CGPoint)translation
{
    CGPoint position = CGPointMake(self.position.x + translation.x, self.position.y + translation.y);
    position.x = MIN(position.x , 0);
    position.x = MAX(self.scene.size.width - self.size.width, position.x);
    position.y = MIN(position.y , 0);
    position.y = MAX(position.y, self.scene.size.height - self.size.height);
    self.position = position;
    DLog(@"self.postion = %@", NSStringFromCGPoint(self.position));
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (2 == touches.count) {
        NSEnumerator *setEnumerator = [touches objectEnumerator];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        id value = nil;
        while (value = [setEnumerator nextObject]) {
            [arr addObject:value];
        }
        UITouch *touch1 = [arr objectAtIndex:0];
        UITouch *touch2 = [arr objectAtIndex:1];
        CGPoint position1 = [touch1 locationInNode:self];
        CGPoint position2 = [touch2 locationInNode:self];
        self.velocity = WLDistanceBetweenPoints(position1, position2);
        self.pinchCenter = CGPointMake((position1.x + position2.x) / 2, (position1.y + position2.y) / 2);
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint previousPoint = [touch previousLocationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, currentPoint.y - previousPoint.y);
        [self handlePanTranslation:translation];
    } else if (2 == touches.count) {
        NSEnumerator *setEnumerator = [touches objectEnumerator];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:2];
        id value = nil;
        while (value = [setEnumerator nextObject]) {
            [arr addObject:value];
        }
        UITouch *touch1 = [arr objectAtIndex:0];
        UITouch *touch2 = [arr objectAtIndex:1];
        CGPoint position1 = [touch1 locationInNode:self];
        CGPoint position2 = [touch2 locationInNode:self];
        
        // pinch center keep center
        CGPoint center = CGPointMake((position1.x + position2.x) / 2, (position1.y + position2.y) / 2);
        CGPoint translation = CGPointMake(center.x - self.pinchCenter.x, center.y - self.pinchCenter.y);
        [self handlePanTranslation:translation];
        
        // calculate pinch rate and execute pinch
        CGFloat velocity = WLDistanceBetweenPoints(position1, position2);
        CGFloat rate = self.currentRate + (velocity - self.velocity) / (self.velocity * 10);
        CGFloat minWidth = self.scene.size.width;
        CGFloat minHeight = self.scene.size.height;
        CGFloat minWidthRate = minWidth / 600.f;
        CGFloat minHeightRate = minHeight / 400.f;
        rate = MIN(rate, 1.5);
        rate = MAX(rate, minWidthRate);
        rate = MAX(rate, minHeightRate);
        self.xScale = rate;
        self.yScale = rate;
        self.currentRate = rate;
        // garuntee edge from out of screen
        CGPoint currentPosition = self.position;
        if (currentPosition.x + self.size.width < minWidth) {
            currentPosition.x = minWidth - self.size.width;
        }
        if (currentPosition.y + self.size.height < minHeight) {
            currentPosition.y = minHeight - self.size.height;
        }
        self.position = currentPosition;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

@end
