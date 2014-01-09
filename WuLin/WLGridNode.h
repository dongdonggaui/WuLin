//
//  WLGridNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLLayerdNode.h"

@interface WLGridNode : WLLayerdNode

- (void)moveToPointInMathCoord:(CGPoint)point;
- (void)showGrid;
- (void)hideGrid;

@end
