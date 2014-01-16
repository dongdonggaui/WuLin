//
//  SKSpriteNode+StretchableBacgroundNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-16.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "SKSpriteNode+StretchableBacgroundNode.h"

@implementation SKSpriteNode (StretchableBacgroundNode)

- (SKSpriteNode *)WL_nodeWithLeftImage:(NSString *)leftImage middleImage:(NSString *)middleImage rightImage:(NSString *)rightImage size:(CGSize)size
{
    SKSpriteNode *node = [SKSpriteNode node];
    node.anchorPoint = CGPointZero;
    
    SKSpriteNode *leftNode = [SKSpriteNode spriteNodeWithImageNamed:leftImage];
    leftNode.xScale = 0.5;
    leftNode.yScale = 0.5;
    leftNode.anchorPoint = CGPointZero;
    leftNode.name = @"leftNode";
    
    SKSpriteNode *rightNode = [SKSpriteNode spriteNodeWithImageNamed:rightImage];
    rightNode.xScale = 0.5;
    rightNode.yScale = 0.5;
    rightNode.name = @"rightNode";
    rightNode.anchorPoint = CGPointZero;
    rightNode.position = CGPointMake(size.width - rightNode.size.width, 0);
    
    SKTexture *middle = [SKTexture textureWithImageNamed:middleImage];
    SKSpriteNode *middleNode = [SKSpriteNode spriteNodeWithTexture:middle size:CGSizeMake((size.width - leftNode.size.width - rightNode.size.width) * 2, middle.size.height)];
    middleNode.xScale = 0.5;
    middleNode.yScale = 0.5;
    middleNode.name = @"middleNode";
    middleNode.anchorPoint = CGPointZero;
    middleNode.position = CGPointMake(leftNode.size.width, 0);
    
    [node addChild:leftNode];
    [node addChild:middleNode];
    [node addChild:rightNode];
    node.size = CGSizeMake(size.width, leftNode.size.height);
    
    return node;
}

@end
