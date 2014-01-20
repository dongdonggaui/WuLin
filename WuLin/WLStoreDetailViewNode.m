//
//  WLStoreDetailViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-12.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLStoreDetailViewNode.h"
#import "WLScrollViewNode.h"

#import "WLButtonNode+WLStoreItem.h"
#import "SKSpriteNode+StretchableBacgroundNode.h"

const NSString *kWLDidSelectedTobeBuildNotification = @"kWLDidSelectedTobeBuildNotification";

@interface WLStoreDetailViewNode () <WLButtonNodeDelegate>

@property (nonatomic) WLScrollViewNode *scrollNode;
@property (nonatomic) SKLabelNode *moneyLabel;
@property (nonatomic) SKLabelNode *woodLabel;
@property (nonatomic) SKLabelNode *diamondLabel;

@end

@implementation WLStoreDetailViewNode

#pragma mark - Designate init
- (instancetype)initWithItems:(NSArray *)items size:(CGSize)size
{
    self = [super initWithColor:[SKColor darkGrayColor] size:size];
    if (self) {
        self.items = items;
        self.anchorPoint = CGPointZero;
        WLScrollViewNode *scrollNode = [WLScrollViewNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(size.width, size.height - 88)];
        scrollNode.position = CGPointMake(0, 44);
        [self addChild:scrollNode];
        self.scrollNode = scrollNode;
        
        SKSpriteNode *toolbar = [[SKSpriteNode node] WL_nodeWithLeftImage:@"nav_bg_0" middleImage:@"nav_bg_1" rightImage:@"nav_bg_2" size:CGSizeMake(size.width, 44)];
        toolbar.anchorPoint = CGPointZero;
        
        SKLabelNode *moneyLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        moneyLabel.text = @"999";
        moneyLabel.fontSize = 14;
        moneyLabel.position = CGPointMake((self.size.width / 3 - moneyLabel.frame.size.width) / 2, (toolbar.size.height - moneyLabel.frame.size.height) / 2);
        [toolbar addChild:moneyLabel];
        self.moneyLabel = moneyLabel;
        
        SKLabelNode *woodLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        woodLabel.text = @"888";
        woodLabel.fontSize = 14;
        woodLabel.position = CGPointMake(self.size.width / 3 + (self.size.width / 3 - woodLabel.frame.size.width) / 2, (toolbar.size.height - woodLabel.frame.size.height) / 2);
        [toolbar addChild:woodLabel];
        self.woodLabel = woodLabel;
        
        SKLabelNode *diamondLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        diamondLabel.text = @"999";
        diamondLabel.fontSize = 14;
        diamondLabel.position = CGPointMake(self.size.width / 3 * 2 + (self.size.width / 3 - diamondLabel.frame.size.width) / 2, (toolbar.size.height - diamondLabel.frame.size.height) / 2);
        [toolbar addChild:diamondLabel];
        self.diamondLabel = diamondLabel;
        toolbar.yScale = 0.6;
        
        [self addChild:toolbar];
        
        [self storeDetailGeneralInit];
    }
    
    return self;
}

#pragma mark - override
- (void)didReceiveAddToParentNotification:(NSNotification *)notification
{
    if (notification.object == self) {
        self.navigationNode.navigationBar.title = self.title;
    }
}

#pragma mark - Private methods
- (void)storeDetailGeneralInit
{
    if (self.items) {
        CGFloat buttonWidth = iPad ? 250 : 150;
        CGFloat buttonHeight = self.scrollNode.size.height -  40;
        CGFloat margin = iPad ? 30 : 20;
        for (int i = 0; i < self.items.count; i++) {
            NSDictionary *item = [self.items objectAtIndex:i];
            WLButtonNode *button;
            NSString *imageName = [item objectForKey:@"image"];
            if (imageName != nil && imageName.length > 0) {
                button = [WLButtonNode WL_storeDetailButtonWithImageName:[item objectForKey:@"image"] title:nil size:CGSizeMake(buttonWidth, buttonHeight)];
                button.delegate = self;
                button.name = @"temple";
            } else {
                button = [WLButtonNode WL_storeDetailButtonWithImageName:nil title:nil size:CGSizeMake(buttonWidth, buttonHeight)];
                button.delegate = self;
                button.title = [item objectForKey:@"title"];
            }
//            if (0 == i) {
//                button = [WLButtonNode WL_storeDetailButtonWithImageName:[item objectForKey:@"image"] title:nil size:CGSizeMake(buttonWidth, buttonHeight)];
//                button.delegate = self;
//                button.name = @"temple";
//            } else {
//                button = [WLButtonNode WL_storeDetailButtonWithImageName:nil title:nil size:CGSizeMake(buttonWidth, buttonHeight)];
//                button.delegate = self;
//                button.title = [item objectForKey:@"title"];
//            }
            [button.userData removeAllObjects];
            [button.userData addEntriesFromDictionary:item];
            button.position = CGPointMake(margin + i * (button.size.width + margin), margin);
            [self.scrollNode addChild:button];
        }
//        self.scrollNode.size = CGSizeMake(self.scrollNode.calculateAccumulatedFrame.size.width + margin, self.scrollNode.calculateAccumulatedFrame.size.height);
    }
}

#pragma mark - button delegate
- (void)buttonNodeDidTapped:(WLButtonNode *)buttonNode
{
    if ([buttonNode.name isEqualToString:@"temple"]) {
        [self.navigationNode dismiss];
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)kWLDidSelectedTobeBuildNotification object:buttonNode];
    }
}

@end
