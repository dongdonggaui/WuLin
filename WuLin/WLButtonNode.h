//
//  WLButtonNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

extern const NSString *WLButtonNodeDidTappedNotification;

@interface WLButtonNode : SKSpriteNode

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *selectedTitle;
@property (nonatomic, getter = isSelected) BOOL selected;

@end
