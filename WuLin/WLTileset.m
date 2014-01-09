//
//  WLTileset.m
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLTileset.h"

@implementation WLTileset

+ (instancetype)tileSetWithFirstgid:(NSInteger)firstgid
                               name:(NSString *)name
                          tileWidth:(NSInteger)tileWidth
                         tileHeight:(NSInteger)tileHeight
                        imageSource:(NSString *)imageSource
                         imageWidth:(NSInteger)imageWidth
                        imageHeight:(NSInteger)imageHeight
{
    WLTileset *tileset = [[self alloc] init];
    tileset.firstgid = firstgid;
    tileset.name = name;
    tileset.image = imageSource;
    tileset.tileWidth = tileWidth;
    tileset.tileHeight = tileHeight;
    tileset.imageWidth = imageWidth;
    tileset.imageHeight = imageHeight;
    tileset.tileAmountWidth = floor(imageWidth / tileHeight);
    tileset.lastgid = tileset.tileAmountWidth * floor(imageHeight / tileHeight) + firstgid - 1;
    
    return tileset;
}

+ (instancetype)tileSetWithProperties:(NSDictionary *)properties
{
    WLTileset *tileset =
    [self tileSetWithFirstgid:[[properties objectForKey:@"firstid"] integerValue]
                         name:[properties objectForKey:@"name"]
                    tileWidth:[[properties objectForKey:@"tilewidth"] integerValue]
                   tileHeight:[[properties objectForKey:@"tileHeight"] integerValue]
                  imageSource:[properties objectForKey:@"image"]
                   imageWidth:[[properties objectForKey:@"imageWidth"] integerValue]
                  imageHeight:[[properties objectForKey:@"iamgeHeight"] integerValue]];
    
    return tileset;
}

@end
