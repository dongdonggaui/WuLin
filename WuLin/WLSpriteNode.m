//
//  WLSpriteNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLSpriteNode.h"

@implementation WLSpriteNode


#pragma mark - Public Methods
- (void)handlePanTranslation:(CGPoint)translation
{
    CGPoint position = CGPointMake(self.position.x + translation.x, self.position.y + translation.y);
    position.x = MIN(position.x , 0);
    position.x = MAX(self.scene.size.width - self.size.width, position.x);
    position.y = MIN(position.y , 0);
    position.y = MAX(position.y, self.scene.size.height - self.size.height);
    self.position = position;
}

@end
