//
//  WLBarButtonItemNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLBarButtonItemNode.h"

@interface WLBarButtonItemNode ()

@property (nonatomic) id<WLBarButtonItemNodeDelegate> delegate;

@end

@implementation WLBarButtonItemNode

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name delegate:(id<WLBarButtonItemNodeDelegate>)delegate
{
    WLBarButtonItemNode *node = [self spriteNodeWithImageNamed:name];
    if (node) {
        node.xScale = 0.6;
        node.yScale = 0.6;
        node.delegate = delegate;
        node.userInteractionEnabled = YES;
        node.anchorPoint = CGPointZero;
    }
    
    return node;
}

#pragma mark - touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(buttonItemDidTapped:)]) {
        [self.delegate buttonItemDidTapped:self];
    }
}

@end
