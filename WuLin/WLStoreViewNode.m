//
//  WLStoreViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLStoreViewNode.h"
#import "WLButtonNode.h"
#import "WLStoreDetailViewNode.h"

@interface WLStoreViewNode () <WLButtonNodeDelegate>

@end

@implementation WLStoreViewNode

+ (instancetype)spriteNodeWithColor:(UIColor *)color size:(CGSize)size
{
    WLStoreViewNode *node = [super spriteNodeWithColor:color size:size];
    if (node) {
        [node generalInit];
    }
    
    return node;
}

+ (instancetype)spriteNodeWithImageNamed:(NSString *)name
{
    WLStoreViewNode *node = [super spriteNodeWithImageNamed:name];
    if (node) {
        [node generalInit];
    }
    
    return node;
}

+ (instancetype)storeWithImageName:(NSString *)imageName size:(CGSize)size
{
    WLStoreViewNode *node = [super spriteNodeWithImageNamed:imageName];
    if (node) {
        node.size = size;
        [node generalInit];
    }
    
    return node;
}

#pragma mark - override
- (void)didReceiveAddToParentNotification:(NSNotification *)notification
{
    if (notification.object == self) {
        self.navigationNode.navigationBar.title = self.title;
    }
}

#pragma mark - Private methods
- (void)generalInit
{
    self.anchorPoint = CGPointZero;
    self.title = @"商店";
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            CGFloat width = (self.size.width - 120) / 3;
            CGFloat height = (self.size.height - 114) / 2;
            WLButtonNode *button = [WLButtonNode buttonWithColor:[SKColor purpleColor] size:CGSizeMake(width, height) delegate:self];
            int index = i * 3 + j + 1;
            button.name = [NSString stringWithFormat:@"storeItem%d", index];
            button.position = CGPointMake(30 + j * (20 + width), 30 + i * (20 + height));
            [self addChild:button];
            
            switch (index) {
                default:
                case 1:
                    button.title = @"宝藏";
                    break;
                case 2:
                    button.title = @"资源";
                    break;
                case 3:
                    button.title = @"装饰";
                    break;
                case 4:
                    button.title = @"军队";
                    break;
                case 5:
                    button.title = @"防御";
                    break;
                case 6:
                    button.title = @"护盾";
                    break;
                case 7:
                    button.title = @"xx";
                    break;
                case 8:
                    button.title = @"xx";
                    break;
            }
        }
    }
}

#pragma mark - button node delegate
- (void)buttonNodeDidTapped:(WLButtonNode *)buttonNode
{
    DLog(@"222");
    if ([buttonNode.name isEqualToString:@"storeItem1"]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"test_store_detail_items" withExtension:@"plist"];
        NSArray *arr = [NSArray arrayWithContentsOfURL:url];
        WLStoreDetailViewNode *node = [[WLStoreDetailViewNode alloc] initWithItems:arr size:self.size];
        node.title = buttonNode.title;
        [self.navigationNode pushNode:node];
    }
}

@end
