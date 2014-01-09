//
//  WLGridUtility.h
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLLayerdNode;

@interface WLGridUtility : NSObject

+ (CGPoint)convertCoordinateToScene:(CGPoint)tileCoordinate withZoomRate:(CGFloat)zoomRate offset:(CGPoint)offset;
+ (void)generateTilesInNode:(WLLayerdNode *)theNode withGridWidth:(NSInteger)gridWidth gridHeight:(NSInteger)gridHeight;

@end
