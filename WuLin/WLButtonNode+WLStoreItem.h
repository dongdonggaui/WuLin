//
//  WLButtonNode+WLStoreItem.h
//  WuLin
//
//  Created by huangluyang on 14-1-16.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLButtonNode.h"

@interface WLButtonNode (WLStoreItem)

+ (instancetype)WL_storeButtonWithImageName:(NSString *)imageName
                                      title:(NSString *)title
                                       size:(CGSize)size;

+ (instancetype)WL_storeDetailButtonWithImageName:(NSString *)imageName
                                            title:(NSString *)title
                                             size:(CGSize)size;

- (void)addItemImage:(NSString *)imageName;

@end
