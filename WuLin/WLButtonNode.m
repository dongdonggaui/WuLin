//
//  WLButtonNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLButtonNode.h"

const NSString *WLButtonNodeDidTappedNotification = @"WLButtonNodeDidTappedNotification";

@interface WLButtonNode ()

@property (nonatomic) SKLabelNode *titleLabel;

@end

@implementation WLButtonNode

+ (instancetype)buttonWithColor:(UIColor *)color size:(CGSize)size delegate:(id<WLButtonNodeDelegate>)delegate
{
    WLButtonNode *button = [self spriteNodeWithColor:color size:size];
    if (button) {
        button.delegate = delegate;
        [button generalInit];
    }
    
    return button;
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLButtonNode *button = [super spriteNodeWithColor:color size:size];
    if (button) {
        [button generalInit];
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

#pragma mark - Private methods
- (void)generalInit
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 20;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    self.titleLabel = label;
    self.selected = NO;
    [self addChild:label];
    self.userInteractionEnabled = YES;
}

#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
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

@end
