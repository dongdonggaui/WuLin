//
//  WLBuildingNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridNode.h"

@interface WLBuildingNode : WLGridNode

@property (nonatomic, readonly) CGPoint physicalCoord;
@property (nonatomic, readonly) BOOL isBuilding;


+ (instancetype)buildingWithShadowImageName:(NSString *)imageName xTileCount:(NSInteger)xTileCount yTileCount:(NSInteger)yTileCount;

- (void)cancelBuild;
- (void)cofrimBuild;

@end
