//
//  WLGridManager.h
//  WuLin
//
//  Created by huangluyang on 14-1-13.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WLLayerdNode;
@interface WLGridManager : NSObject

@property (nonatomic) CGFloat   currentRate;
@property (nonatomic) CGFloat   tileWidth;
@property (nonatomic) CGFloat   tileHeight;
@property (nonatomic) NSInteger xGridCount;
@property (nonatomic) NSInteger yGridCount;
@property (nonatomic) CGPoint   basePoint;

+ (instancetype)sharedInstance;

+ (CGPoint)convertCoordinateToSceneWitGridX:(NSInteger)x
                                      gridY:(NSInteger)y;

+ (void)generateTilesInNode:(WLLayerdNode *)theNode
              withGridWidth:(NSInteger)gridWidth
                 gridHeight:(NSInteger)gridHeight;

@end
