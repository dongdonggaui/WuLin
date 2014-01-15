//
//  WLBuildingNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLGridNode.h"

@class JSTileMap;
@interface WLBuildingNode : WLGridNode

@property (nonatomic, readonly) CGPoint physicalCoord;
@property (nonatomic, readonly) BOOL isBuilding;
@property (nonatomic, readonly) SKSpriteNode * buildingFoundation;


+ (instancetype)buildingWithShadowImageName:(NSString *)imageName xTileCount:(int)xTileCount yTileCount:(int)yTileCount;
- (instancetype)initWithName:(NSString *)name;

- (void)cancelBuild;
- (void)confirmBuild;

@end
