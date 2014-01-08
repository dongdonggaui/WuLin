//
//  WLGridNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WLGridNode : SKSpriteNode

- (void)moveToPointInMathCoord:(CGPoint)point;
- (CGPoint)convertCoordinateToScene:(CGPoint)tileCoordinate offset:(CGPoint)offset;

@end
