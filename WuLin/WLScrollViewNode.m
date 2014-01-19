//
//  WLScrollViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

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
        _contentNode.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        _contentNode.physicsBody.linearDamping = 1.f;
        _contentNode.physicsBody.mass = 3.f;
        _contentNode.physicsBody.friction = 1.f;
        _contentNode.physicsBody.allowsRotation = NO;
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

- (BOOL)scrollBounce
{
    if (self.contentNode.position.x > 0) {
        SKAction *rollback = [SKAction moveToX:0 duration:0.18];
        rollback.timingMode = SKActionTimingEaseInEaseOut;
        [self.contentNode runAction:rollback];
        return YES;
    } else if (self.contentNode.size.width + self.contentNode.position.x < self.size.width) {
        SKAction *rollback = [SKAction moveToX:self.size.width - self.contentNode.size.width - 20 duration:0.18];
        rollback.timingMode = SKActionTimingEaseInEaseOut;
        [self.contentNode runAction:rollback];
        return YES;
    }
    
    return NO;
}

#pragma mark - Touches
BOOL isPanGesture = NO;
CGPoint lastTranlsation;
NSTimeInterval lastTimeStamp;
NSTimeInterval moveTimeInterval;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    isPanGesture = NO;
    if ([self.contentNode actionForKey:@"scroll"]) {
        [self.contentNode removeActionForKey:@"scroll"];
    }
    if (2 == touches.count) {
        
    } else if (1 == touches.count) {
        lastTranlsation = CGPointZero;
        lastTimeStamp = 0;
        moveTimeInterval = 0;
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
        lastTranlsation = translation;
        CGPoint postion = self.contentNode.position;
        if (self.contentSize.width > self.size.width && self.contentSize.height > self.size.height) {
            postion.x += translation.x;
            postion.y += translation.y;
        } else if (self.contentSize.width > self.size.width) {
            CGFloat delta = translation.x;
            if (postion.x > 30 || postion.x < self.scene.size.width - self.contentNode.size.width - 20 - 30) {
                delta /= 2.f;
            } else if (postion.x > 50 || postion.x < self.scene.size.width - self.contentNode.size.width - 20 - 50) {
                delta /= 4.f;
            }
            postion.x += delta;
        } else if (self.contentSize.height > self.size.height) {
            postion.y += translation.y;
        }
        self.contentNode.position = postion;
        moveTimeInterval = touch.timestamp - lastTimeStamp;
        lastTimeStamp = touch.timestamp;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        if (isPanGesture) {
            if ([self scrollBounce]) {
                return;
            }
            if (lastTranlsation.x != 0 || lastTranlsation.y != 0) {
                CGFloat xVelocity = lastTranlsation.x / moveTimeInterval;
                CGFloat yVelocity = lastTranlsation.y / moveTimeInterval;
                NSTimeInterval xStopTimeInterval = abs(xVelocity) / 2500.f;
                NSTimeInterval yStopTimeInterval = abs(yVelocity) / 2500.f;
                
                CGPoint currentPosition = self.contentNode.position;
                CGFloat maxMove = 10.f;
                
                CGFloat xMove = xVelocity * xStopTimeInterval / 2;
                CGFloat afterMove = currentPosition.x + xMove;
                xMove = afterMove > maxMove ? maxMove - currentPosition.x : xMove;
                xMove = afterMove < self.scene.size.width - self.contentNode.size.width - 20 - maxMove ? self.scene.size.width - self.contentNode.size.width - 20 - maxMove - currentPosition.x : xMove;
                
                CGFloat yMove = yVelocity * yStopTimeInterval / 2;
                
                SKAction *roll = [SKAction moveByX:xMove y:yMove duration:xStopTimeInterval];
                roll.timingMode = SKActionTimingEaseOut;
                SKAction *complete = [SKAction runBlock:^{
                    [self scrollBounce];
                }];
                SKAction *scroll = [SKAction sequence:@[roll, complete]];
                [self.contentNode runAction:scroll withKey:@"scroll"];
            }
        }
    }
}

- (void)test
{
    [self.contentNode.physicsBody applyImpulse:CGVectorMake(-100, 0)];
    DLog(@"velocity = %f", self.contentNode.physicsBody.velocity.dx);
}

@end
