//
//  WLTileMapBuilder.h
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTileMapBuilder : NSObject

@property (nonatomic, readonly) NSInteger totalTileSets;

+ (instancetype)builderWithFileName:(NSString *)fileName;
- (void)loadSources;

@end
