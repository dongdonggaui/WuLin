//
//  UINavigationBar+WuLin.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "UINavigationBar+WuLin.h"

@implementation UINavigationBar (WuLin)

-(CGSize)sizeThatFits:(CGSize)size{
    
    CGSize newSize = CGSizeMake(self.frame.size.width, 44);
    return newSize;
}

@end
