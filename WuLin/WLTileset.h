//
//  WLTileset.h
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLTileset : NSObject

@property (nonatomic) NSInteger firstgid;
@property (nonatomic) NSInteger lastgid;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger tileWidth;
@property (nonatomic) NSInteger tileHeight;
@property (nonatomic) NSString *image;
@property (nonatomic) NSInteger imageWidth;
@property (nonatomic) NSInteger imageHeight;
//@property (nonatomic) NSInteger margin;
//@property (nonatomic) NSInteger spacing;
//@property (nonatomic) NSArray *terrains;
//@property (nonatomic) NSDictionary *properties;
//@property (nonatomic) NSDictionary *tileOffset;
//@property (nonatomic) NSArray *tiles;
@property (nonatomic) NSInteger tileAmountWidth;

+ (instancetype)tileSetWithFirstgid:(NSInteger)firstgid
                               name:(NSString *)name
                          tileWidth:(NSInteger)tileWidth
                         tileHeight:(NSInteger)tileHeight
                        imageSource:(NSString *)imageSource
                         imageWidth:(NSInteger)imageWidth
                        imageHeight:(NSInteger)imageHeight;
+ (instancetype)tileSetWithProperties:(NSDictionary *)properties;

@end
