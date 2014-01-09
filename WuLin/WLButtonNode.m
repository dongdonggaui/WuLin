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

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLButtonNode *button = [super spriteNodeWithColor:color size:size];
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 20;
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    button.titleLabel = label;
    button.selected = NO;
    [button addChild:label];
    
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

#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.isSelected) {
        self.selected = NO;
    } else {
        self.selected = YES;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)WLButtonNodeDidTappedNotification object:self];
}

@end
