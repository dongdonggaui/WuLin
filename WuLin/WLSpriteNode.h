//
//  WLSpriteNode.h
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface WLSpriteNode : SKSpriteNode

- (void)handlePanTranslation:(CGPoint)translation limitX:(BOOL)limitX limitY:(BOOL)limitY;

@end
