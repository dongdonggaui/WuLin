//
//  WLNavigationBarNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WLNavigationBarNode : SKSpriteNode

@property (nonatomic) NSString * title;

+ (instancetype)barWithResizeBackgroundImages:(NSArray *)backgroundImages
                                         size:(CGSize)size;
- (instancetype)initWithTitle:(NSString *)title backgroundImageName:(NSString *)imageName;

@end
