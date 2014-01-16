//
//  WLShadowLabelNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-16.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLShadowLabelNode.h"

@interface WLShadowLabelNode ()

@property (nonatomic) SKLabelNode *shadowLabel;

@end

const CGFloat offsetX = 2.f;
const CGFloat offsetY = 2.f;

@implementation WLShadowLabelNode

+ (instancetype)shadowLabel
{
    WLShadowLabelNode *completedString = [self labelNodeWithFontNamed:@"Arial"];
    completedString.fontColor = [SKColor whiteColor];
    
    
    SKLabelNode *dropShadow = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    dropShadow.fontColor = [SKColor blackColor];
//    dropShadow.zPosition = completedString.zPosition - 1;
    dropShadow.position = CGPointMake(-1, -7);
    completedString.shadowLabel = dropShadow;
    
    [completedString addChild:dropShadow];
    
    return completedString;
}

#pragma mark - setters & getters
- (void)setText:(NSString *)text
{
    [super setText:text];
    self.shadowLabel.text = text;
}

- (void)setFontSize:(CGFloat)fontSize
{
    [super setFontSize:fontSize];
    self.shadowLabel.fontSize = fontSize;
}

@end
