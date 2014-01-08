//
//  WLButtonNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLButtonNode.h"

const NSString *WLButtonNodeDidTappedNotification = @"WLButtonNodeDidTappedNotification";

@implementation WLButtonNode

#pragma mark - Touches
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)WLButtonNodeDidTappedNotification object:nil];
}

@end
