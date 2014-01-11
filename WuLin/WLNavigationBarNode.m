//
//  WLNavigationBarNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLNavigationBarNode.h"

@interface WLNavigationBarNode ()

@property (nonatomic) SKLabelNode *titleLabel;

@end

@implementation WLNavigationBarNode

+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture size:(CGSize)size
{
    WLNavigationBarNode *bar = [super spriteNodeWithTexture:texture size:size];
    if (bar) {
        [bar generalInit];
    }
    
    return bar;
}

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLNavigationBarNode *bar = [super spriteNodeWithColor:color size:size];
    if (bar) {
        [bar generalInit];
    }
    
    return bar;
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLNavigationBarNode *bar = [super spriteNodeWithImageNamed:name];
    if (bar) {
        [bar generalInit];
    }
    
    return bar;
}

- (instancetype)initWithTitle:(NSString *)title backgroundImageName:(NSString *)imageName
{
    self = [super initWithImageNamed:imageName];
    if (self) {
        [self generalInit];
        self.title = title;
    }
    
    return self;
}

#pragma mark - setters & getters
- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        _title = title;
        self.titleLabel.text = title;
        self.titleLabel.position = CGPointMake((self.size.width - self.titleLabel.frame.size.width) / 2, (self.size.height - self.titleLabel.frame.size.height));
    }
}

#pragma mark - Private methods
- (void)generalInit
{
    self.userInteractionEnabled = YES;
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.fontSize = 17;
    label.fontColor = [SKColor blackColor];
    label.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    [self addChild:label];
    self.titleLabel = label;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    DLog(@"111");
}

@end
