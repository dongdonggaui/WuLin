//
//  WLButtonNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

extern const NSString *WLButtonNodeDidTappedNotification;

@class WLButtonNode;
@protocol WLButtonNodeDelegate <NSObject>

@optional
- (void)buttonNodeDidTapped:(WLButtonNode *)buttonNode;

@end
/**
 *@description 按钮，anchorPoint 只能是默认的(0.5, 0.5)，若修改则titleLable位置显示不正常
 */
@interface WLButtonNode : SKSpriteNode

@property (nonatomic, weak) id<WLButtonNodeDelegate> delegate;

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *selectedTitle;
@property (nonatomic, getter = isSelected) BOOL selected;

+ (instancetype)buttonWithImageName:(NSString *)name
                backgroundImageName:(NSString *)background
                              title:(NSString *)title
                              scale:(CGFloat)scale
                           delegate:(id<WLButtonNodeDelegate>)delegate;

+ (instancetype)buttonWithColor:(UIColor *)color size:(CGSize)size delegate:(id<WLButtonNodeDelegate>)delegate;

@end
