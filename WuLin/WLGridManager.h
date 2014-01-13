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

+ (CGPoint)screenPointAtGridX:(NSInteger)x
                        gridY:(NSInteger)y;
+ (CGPoint)gridAtScreenPoint:(CGPoint)point;

+ (void)generateTilesInNode:(WLLayerdNode *)theNode
              withGridWidth:(NSInteger)gridWidth
                 gridHeight:(NSInteger)gridHeight;

@end
