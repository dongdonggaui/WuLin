//
//  SKSpriteNode+StretchableBacgroundNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-16.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (StretchableBacgroundNode)

- (SKSpriteNode *)WL_nodeWithLeftImage:(NSString *)leftImage middleImage:(NSString *)middleImage rightImage:(NSString *)rightImage size:(CGSize)size;

@end
