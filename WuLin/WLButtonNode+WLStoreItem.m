//
//  WLButtonNode+WLStoreItem.m
//  WuLin
//
//  Created by huangluyang on 14-1-16.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLButtonNode+WLStoreItem.h"

@implementation WLButtonNode (WLStoreItem)

+ (instancetype)WL_storeButtonWithImageName:(NSString *)imageName title:(NSString *)title size:(CGSize)size
{
    WLButtonNode *button = [self buttonWithResizeBackgroundImages:@[@"store_btn_bg_0", @"store_btn_bg_1", @"store_btn_bg_2", @"store_btn_bg_3", @"store_btn_bg_4", @"store_btn_bg_5", @"store_btn_bg_6", @"store_btn_bg_7", @"store_btn_bg_8"]
                                                 foregroundImages:@[@"store_bubble_spark"]
                                                            title:title
                                                             size:size];
    if (!imageName) {
        return button;
    }
    
    SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    imageNode.zPosition = button.zPosition + 1;
    imageNode.anchorPoint = CGPointZero;
    imageNode.xScale = 0.5;
    imageNode.yScale = 0.5;
    imageNode.position = CGPointMake((button.size.width - imageNode.size.width) / 2, 5);
    [button addChild:imageNode];
    
    button.titleLabel.position = CGPointMake(button.size.width / 2, imageNode.position.y + imageNode.size.height / 2 + 3);
    button.titleLabel.fontSize = 13;
    button.titleLabel.zPosition = imageNode.zPosition + 1;
    
    return button;
}

+ (instancetype)WL_storeDetailButtonWithImageName:(NSString *)imageName title:(NSString *)title size:(CGSize)size
{
    WLButtonNode *button = [self buttonWithResizeBackgroundImages:@[@"store_btn_bg_0", @"store_btn_bg_1", @"store_btn_bg_2", @"store_btn_bg_3", @"store_btn_bg_4", @"store_btn_bg_5", @"store_btn_bg_6", @"store_btn_bg_7", @"store_btn_bg_8"]
                                                 foregroundImages:imageName ? @[imageName] : nil
                                                            title:title
                                                             size:size];
    
    return button;
}

- (void)addItemImage:(NSString *)imageName
{
    SKSpriteNode *imageNode = [SKSpriteNode spriteNodeWithImageNamed:imageName];
    imageNode.anchorPoint = CGPointZero;
    imageNode.xScale = 0.8;
    imageNode.yScale = 0.8;
    imageNode.position = CGPointMake((self.size.width - imageNode.size.width) / 2, 35);
    [self addChild:imageNode];
}

@end
