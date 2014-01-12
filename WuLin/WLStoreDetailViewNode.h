//
//  WLStoreDetailViewNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-12.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLSpriteViewNode.h"

@interface WLStoreDetailViewNode : WLSpriteViewNode

@property (nonatomic) NSArray *items;

- (instancetype)initWithItems:(NSArray *)items size:(CGSize)size;

@end
