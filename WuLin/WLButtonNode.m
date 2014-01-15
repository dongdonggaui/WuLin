//
//  WLButtonNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLButtonNode.h"
#import "WLScrollViewNode.h"
#import "WLMyScene.h"

const NSString *WLButtonNodeDidTappedNotification = @"WLButtonNodeDidTappedNotification";

@interface WLButtonNode ()

@property (nonatomic) SKLabelNode *titleLabel;
@property (nonatomic) BOOL isSigleTap;
@property (nonatomic) CGPoint beginTapPoint;
@property (nonatomic) CGSize theInitSize;
@property (nonatomic) BOOL beingZoomDown;
@property (nonatomic) BOOL beingZoomUp;

@end

@implementation WLButtonNode

+ (instancetype)buttonWithImageName:(NSString *)name backgroundImageName:(NSString *)background title:(NSString *)title scale:(CGFloat)scale delegate:(id<WLButtonNodeDelegate>)delegate
{
    WLButtonNode *button = [self spriteNodeWithImageNamed:background];
    if (button) {
        button.delegate = delegate;
        [button buttonGeneralInit];
        button.xScale = scale;
        button.yScale = scale;
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:name];
        image.anchorPoint = CGPointZero;
        image.xScale = [name isEqualToString:@"store_btn_icon"] ? 0.5 : 1;
        image.yScale = [name isEqualToString:@"store_btn_icon"] ? 0.5 : 1;
        
        if (title) {
            button.title = title;
            button.titleLabel.fontSize = 10;
            button.titleLabel.position = CGPointMake(button.titleLabel.position.x, 15);
            image.position = CGPointMake((button.size.width - image.size.width) / 2, button.size.height - image.size.height - 5);
        } else {
            image.position = CGPointMake(10, 10);
        }
        [button addChild:image];
    }
    
    return button;
}

+ (instancetype)buttonWithColor:(UIColor *)color size:(CGSize)size delegate:(id<WLButtonNodeDelegate>)delegate
{
    WLButtonNode *button = [self spriteNodeWithColor:color size:size];
    if (button) {
        button.delegate = delegate;
        [button buttonGeneralInit];
    }
    
    return button;
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLButtonNode *button = [super spriteNodeWithColor:color size:size];
    if (button) {
        [button buttonGeneralInit];
    }
    
    return button;
}

#pragma mark - setters & getters
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        self.titleLabel.text = title;
        CGPoint point = CGPointMake((self.size.width) / 2, (self.size.height) / 2);
        self.titleLabel.position = point;
    }
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        self.titleLabel.text = selected ? self.selectedTitle : self.title;
    }
}

#pragma mark - Private methods
- (void)buttonGeneralInit
{
    self.anchorPoint = CGPointZero;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 20;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.titleLabel = label;
    self.selected = NO;
    [self addChild:label];
    self.userInteractionEnabled = YES;
    self.theInitSize  = self.size;
    self.beingZoomUp = NO;
    self.beingZoomDown = NO;
}

- (void)zoomDown
{
    if (!self.beingZoomDown && !self.beingZoomUp && ![self actionForKey:@"zoomDown"]) {
        self.beingZoomDown = YES;
        DLog(@"555");
        SKAction *zoom = [SKAction scaleTo:0.9 duration:0.1];
        CGFloat xDelta = 0.1 * self.theInitSize.width;
        CGFloat yDelta = 0.1 * self.theInitSize.height;
        SKAction *move = [SKAction moveByX:xDelta / 2 y:yDelta / 2 duration:0.1];
        [self runAction:[SKAction group:@[zoom, move]] withKey:@"zoomDown"];
    }
}

- (void)zoomUp
{
    if (!self.beingZoomUp && self.beingZoomDown && ![self actionForKey:@"zoomUp"]) {
        self.beingZoomUp = YES;
        SKAction *zoom = [SKAction scaleTo:1.1 duration:0.05];
        CGFloat xDelta1 = 0.2 * self.theInitSize.width;
        CGFloat yDelta1 = 0.2 * self.theInitSize.height;
        SKAction *move1 = [SKAction moveByX:-xDelta1 / 2 y:-yDelta1 / 2 duration:0.05];
        SKAction *zoom1 = [SKAction group:@[zoom, move1]];
        SKAction *zoomBack = [SKAction scaleTo:1 duration:0.05];
        CGFloat xDelta2 = 0.1 * self.theInitSize.width;
        CGFloat yDelta2 = 0.1 * self.theInitSize.height;
        SKAction *move2 = [SKAction moveByX:xDelta2 / 2 y:yDelta2 / 2 duration:0.05];
        SKAction *zoom2 = [SKAction group:@[zoomBack, move2]];
        SKAction *complete = [SKAction runBlock:^{
            self.beingZoomDown = NO;
            self.beingZoomUp = NO;
        }];
        [self runAction:[SKAction sequence:@[zoom1, zoom2, complete]] withKey:@"zoomUp"];
    }
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        self.isSigleTap = YES;
        self.beginTapPoint = [[touches anyObject] locationInNode:self];
        [self zoomDown];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        self.isSigleTap = NO;
        [self zoomDown];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        if (abs((int)(location.x - self.beginTapPoint.x)) > 5
            || abs((int)(location.y - self.beginTapPoint.y)) > 5) {
            if (self.isSigleTap) {
                [self zoomUp];
            }
            self.isSigleTap = NO;
            DLog(@"sigleTap : %@", self.isSigleTap ? @"YES" : @"NO");
        }
    }
    if ([self.parent isKindOfClass:[WLScrollViewNode class]]) {
        [self.parent touchesMoved:touches withEvent:event];
    } else if ([self.parent.parent.name isEqualToString:@"screen"]) {
        WLMyScene *scene = (WLMyScene *)self.scene;
        [scene.menpai touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        if (self.isSigleTap) {
            [self zoomUp];
            UITouch *touch = touches.anyObject;
            if (touch.tapCount != 0) {
                if (self.isSelected) {
                    self.selected = NO;
                } else {
                    self.selected = YES;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)WLButtonNodeDidTappedNotification object:self];
                if (self.delegate && [self.delegate respondsToSelector:@selector(buttonNodeDidTapped:)]) {
                    [self.delegate buttonNodeDidTapped:self];
                }
            }
        }
    }
}

@end
