//
//  WLTileMapBuilder.m
//  WuLin
//
//  Created by huangluyang on 14-1-9.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLTileMapBuilder.h"
#import "WLTileset.h"

@interface WLTileMapBuilder ()

@property (nonatomic) NSInteger totalTileSets;
@property (nonatomic) NSMutableArray *tilesets;
@property (nonatomic) NSString *fileName;

@end

@implementation WLTileMapBuilder

+ (instancetype)builderWithFileName:(NSString *)fileName
{
    WLTileMapBuilder *builder = [[self alloc] init];
    builder.fileName = fileName;
    NSMutableArray  *arr = [NSMutableArray array];
    builder.tilesets = arr;
    
    return builder;
}

- (void)loadSources
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"json"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfURL:url];
    if (dic && [dic objectForKey:@"tilesets"]) {
        if ([[dic objectForKey:@"tilesets"] isKindOfClass:[NSArray class]]) {
            NSArray *tilesets = [dic objectForKey:@"tilesets"];
            self.totalTileSets = tilesets.count;
            for (NSDictionary *tileDic in tilesets) {
                WLTileset *tileset = [WLTileset tileSetWithProperties:tileDic];
                [self.tilesets addObject:tileset];
            }
        }
    }
}

@end
