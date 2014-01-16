//
//  WLScrollViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLScrollViewNode.h"

@interface WLScrollViewNode ()

@property (nonatomic) SKSpriteNode *contentNode;
@property (nonatomic) CGSize contentSize;

@end

@implementation WLScrollViewNode

#pragma mark - Designate inits
+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLScrollViewNode *node = [super spriteNodeWithColor:color size:size];
    if (node) {
        [node scrollGeneralInit];
    }
    
    return node;
}

- (void)addChild:(SKNode *)node
{
    if ([self childNodeWithName:@"contentNode"]) {
        [self.contentNode addChild:node];
        CGSize contentSize = self.contentNode.size;
        if (self.contentNode.size.width < self.contentNode.calculateAccumulatedFrame.size.width) {
            contentSize.width = self.contentNode.calculateAccumulatedFrame.size.width;
        }
        if (self.contentNode.size.height < self.contentNode.calculateAccumulatedFrame.size.height) {
            contentSize.height = self.contentNode.calculateAccumulatedFrame.size.height;
        }
        self.contentNode.size = contentSize;
        self.contentSize = contentSize;
        
        return;
    }
    [super addChild:node];
}

- (SKSpriteNode *)contentNode
{
    if (!_contentNode) {
        _contentNode = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:self.size];
        _contentNode.anchorPoint = CGPointZero;
        _contentNode.name = @"contentNode";
        [self addChild:_contentNode];
    }
    
    return _contentNode;
}

#pragma mark - Private methods
- (void)scrollGeneralInit
{
    self.anchorPoint = CGPointZero;
    self.userInteractionEnabled = YES;
    self.contentSize = self.contentNode.size;
}

#pragma mark - Touches
BOOL isPanGesture = NO;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isPanGesture = NO;
    if (2 == touches.count) {
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        isPanGesture = YES;
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInNode:self.parent];
        CGPoint previousPoint = [touch previousLocationInNode:self.parent];
        CGPoint translation = CGPointMake(currentPoint.x - previousPoint.x, 0);
        CGPoint postion = self.contentNode.position;
        if (self.contentSize.width > self.size.width && self.contentSize.height > self.size.height) {
            postion.x += translation.x;
            postion.y += translation.y;
        } else if (self.contentSize.width > self.size.width) {
            postion.x += translation.x;
        } else if (self.contentSize.height > self.size.height) {
            postion.y += translation.y;
        }
        self.contentNode.position = postion;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        if (isPanGesture) {
            if (self.contentNode.position.x > 0) {
                SKAction *rollback = [SKAction moveToX:0 duration:0.18];
                [self.contentNode runAction:rollback];
            } else if (self.contentNode.size.width + self.contentNode.position.x < self.size.width) {
                SKAction *rollback = [SKAction moveToX:self.size.width - self.contentNode.size.width - 20 duration:0.18];
                [self.contentNode runAction:rollback];
            }
        }
    }
}

@end
