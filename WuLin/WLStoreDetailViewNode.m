//
//  WLStoreDetailViewNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-12.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLStoreDetailViewNode.h"
#import "WLScrollViewNode.h"
#import "WLButtonNode.h"

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
        WLScrollViewNode *scrollNode = [WLScrollViewNode spriteNodeWithColor:[SKColor whiteColor] size:CGSizeMake(10, size.height - 88)];
        scrollNode.position = CGPointMake(0, 44);
        [self addChild:scrollNode];
        self.scrollNode = scrollNode;
        
        SKSpriteNode *toolbar = [SKSpriteNode spriteNodeWithColor:[SKColor lightGrayColor] size:CGSizeMake(size.width, 44)];
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
        for (int i = 0; i < self.items.count; i++) {
            WLButtonNode *button = [WLButtonNode buttonWithColor:[SKColor brownColor] size:CGSizeMake(150, self.scrollNode.size.height - 40) delegate:self];
            button.position = CGPointMake(20 + i * (button.size.width + 20), 20);
            button.title = [self.items objectAtIndex:i];
            [self.scrollNode addChild:button];
        }
        self.scrollNode.size = CGSizeMake(self.scrollNode.calculateAccumulatedFrame.size.width + 20, self.scrollNode.calculateAccumulatedFrame.size.height);
    }
}

@end
