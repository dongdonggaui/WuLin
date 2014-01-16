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
#import "WLShadowLabelNode.h"

#import "SKSpriteNode+StretchableBacgroundNode.h"

const NSString *WLButtonNodeDidTappedNotification = @"WLButtonNodeDidTappedNotification";

@interface WLButtonNode ()

@property (nonatomic) WLShadowLabelNode *titleLabel;
@property (nonatomic) BOOL isSigleTap;
@property (nonatomic) CGPoint beginTapPoint;
@property (nonatomic) CGSize theInitSize;
@property (nonatomic) CGFloat theInitScale;
@property (nonatomic) BOOL beingZoomDown;
@property (nonatomic) BOOL beingZoomUp;

@end

@implementation WLButtonNode

+ (instancetype)buttonWithImageName:(NSString *)name backgroundImageName:(NSString *)background title:(NSString *)title scale:(CGFloat)scale delegate:(id<WLButtonNodeDelegate>)delegate
{
    WLButtonNode *button = [self spriteNodeWithImageNamed:background];
    if (button) {
        button.theInitScale = scale;
        button.delegate = delegate;
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:name];
        image.anchorPoint = CGPointZero;
//        image.xScale = scale;
//        image.yScale = scale;
        [button addChild:image];
        
        if (title) {
            button.title = title;
            button.titleLabel.fontSize = 17;
            button.titleLabel.position = CGPointMake(button.titleLabel.position.x, 20);
            image.position = CGPointMake(floorf((button.size.width - image.size.width) / 2), floorf(button.size.height - image.size.height - 10));
        } else {
            image.position = CGPointMake(floorf((button.size.width - image.size.width) / 2), floorf((button.size.height - image.size.height) / 2));
        }
        button.xScale = scale;
        button.yScale = scale;
        button.size = CGSizeMake(floorf(button.size.width), floorf(button.size.height));
        [button buttonGeneralInit];
        DLog(@"button size = %@, image size = %@, init size = %@", NSStringFromCGSize(button.size), NSStringFromCGSize(image.size), NSStringFromCGSize(button.theInitSize));
    }
    
    return button;
}

+ (instancetype)buttonWithResizeBackgroundImages:(NSArray *)backgroundImages
                                foregroundImages:(NSArray *)images
                                           title:(NSString *)title
                                            size:(CGSize)size
{
    WLButtonNode *button = [super node];
    if (button) {
        button.size = size;
        button.theInitScale = 1;
        if (backgroundImages && backgroundImages.count > 0) {
            if (backgroundImages.count == 3) {
                NSString *leftNodeName   = [backgroundImages objectAtIndex:0];
                NSString *middleNodeName = [backgroundImages objectAtIndex:1];
                NSString *rightNodeName  = [backgroundImages objectAtIndex:2];
                
                SKSpriteNode *node = [button WL_nodeWithLeftImage:leftNodeName
                                                      middleImage:middleNodeName
                                                       rightImage:rightNodeName
                                                             size:size];
                [button addChild:node];
            }
            else if (backgroundImages.count == 9) {
                SKSpriteNode *topNode, *middleNode, *bottomNode;
                for (int i = 0; i < backgroundImages.count; i+=3) {
                    NSString *leftNodeName   = [backgroundImages objectAtIndex:i];
                    NSString *middleNodeName = [backgroundImages objectAtIndex:i + 1];
                    NSString *rightNodeName  = [backgroundImages objectAtIndex:i + 2];
                    
                    SKSpriteNode *node = [button WL_nodeWithLeftImage:leftNodeName
                                                          middleImage:middleNodeName
                                                           rightImage:rightNodeName
                                                                 size:size];
                    if (i == 0) {
                        topNode = node;
                    } else if (i == 3) {
                        middleNode = node;
                    } else if (i == 6) {
                        bottomNode = node;
                    }
                }
                topNode.position = CGPointMake(0, size.height - topNode.size.height);
                bottomNode.position = CGPointZero;
                middleNode.position = CGPointMake(0, bottomNode.size.height - 5);
                CGFloat middleHeight = size.height - topNode.size.height - bottomNode.size.height + 10;
                middleNode.size = CGSizeMake(size.width, middleHeight);
                for (SKSpriteNode *childNode in middleNode.children) {
                    childNode.size = CGSizeMake(childNode.size.width, middleHeight);
                }
                
                [button addChild:middleNode];
                [button addChild:topNode];
                [button addChild:bottomNode];
            }
        }
        
        if (images && images.count > 0) {
            for (NSString *imageName in images) {
                SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithImageNamed:imageName];
                imageNode.anchorPoint = CGPointZero;
                imageNode.position = CGPointMake((size.width - imageNode.size.width) / 2, (size.height - imageNode.size.height) / 2);
                [button addChild:imageNode];
            }
        }
        [button buttonGeneralInit];
    }
    
    return button;
}

+ (instancetype)buttonWithColor:(UIColor *)color size:(CGSize)size delegate:(id<WLButtonNodeDelegate>)delegate
{
    WLButtonNode *button = [self spriteNodeWithColor:color size:size];
    if (button) {
        button.delegate = delegate;
        button.theInitScale = 1;
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
    }
}

- (void)setSelected:(BOOL)selected
{
    if (_selected != selected) {
        _selected = selected;
        self.titleLabel.text = selected ? self.selectedTitle : self.title;
    }
}

- (WLShadowLabelNode *)titleLabel
{
    if (!_titleLabel) {
        
        WLShadowLabelNode *label = [WLShadowLabelNode shadowLabel];
        label.fontSize = 20.f;
        label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        label.position = CGPointMake((self.size.width) / 2, (self.size.height) / 2);
        _titleLabel = label;

        [self addChild:_titleLabel];
    }
    
    return _titleLabel;
}

#pragma mark - Private methods
- (void)buttonGeneralInit
{
    self.anchorPoint = CGPointZero;
    self.selected = NO;
    self.userInteractionEnabled = YES;
    self.theInitSize  = CGSizeMake(floorf(self.size.width), floorf(self.size.height));
    self.beingZoomUp = NO;
    self.beingZoomDown = NO;
}

- (void)zoomOut
{
    if (!self.beingZoomDown && !self.beingZoomUp && ![self actionForKey:@"zoomOut"]) {
        self.beingZoomDown = YES;
        SKAction *zoom = [SKAction scaleTo:0.9 * self.theInitScale duration:0.1];
        CGFloat xDelta = 0.1 * self.theInitSize.width;
        CGFloat yDelta = 0.1 * self.theInitSize.height;
        SKAction *move = [SKAction moveByX:xDelta / 2 y:yDelta / 2 duration:0.1];
        [self runAction:[SKAction group:@[zoom, move]] withKey:@"zoomOut"];
    }
}

- (void)zoomIn
{
    if (!self.beingZoomUp && self.beingZoomDown && ![self actionForKey:@"zoomIn"]) {
        self.beingZoomUp = YES;
        SKAction *zoom = [SKAction scaleTo:1.1 * self.theInitScale duration:0.05];
        CGFloat xDelta1 = 0.2 * self.theInitSize.width;
        CGFloat yDelta1 = 0.2 * self.theInitSize.height;
        SKAction *move1 = [SKAction moveByX:-xDelta1 / 2 y:-yDelta1 / 2 duration:0.05];
        SKAction *zoom1 = [SKAction group:@[zoom, move1]];
        SKAction *zoomBack = [SKAction scaleTo:self.theInitScale duration:0.05];
        CGFloat xDelta2 = 0.1 * self.theInitSize.width;
        CGFloat yDelta2 = 0.1 * self.theInitSize.height;
        SKAction *move2 = [SKAction moveByX:xDelta2 / 2 y:yDelta2 / 2 duration:0.05];
        SKAction *zoom2 = [SKAction group:@[zoomBack, move2]];
        SKAction *complete = [SKAction runBlock:^{
            self.beingZoomDown = NO;
            self.beingZoomUp = NO;
        }];
        [self runAction:[SKAction sequence:@[zoom1, zoom2, complete]] withKey:@"zoomIn"];
    }
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        self.isSigleTap = YES;
        self.beginTapPoint = [[touches anyObject] locationInNode:self];
        [self zoomOut];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        self.isSigleTap = NO;
        [self zoomIn];
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
                [self zoomIn];
            }
            self.isSigleTap = NO;
        }
    }
    if ([self.parent.parent isKindOfClass:[WLScrollViewNode class]]) {
        [self.parent.parent touchesMoved:touches withEvent:event];
    } else if ([self.parent.parent.name isEqualToString:@"screen"]) {
        WLMyScene *scene = (WLMyScene *)self.scene;
        [scene.menpai touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (1 == touches.count) {
        if (self.isSigleTap) {
            [self zoomIn];
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
        } else if ([self.parent.parent isKindOfClass:[WLScrollViewNode class]]) {
            [self.parent.parent touchesEnded:touches withEvent:event];
        }
    }
}

@end


