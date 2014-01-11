//
//  WLNavigationNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLNavigationNode.h"
#import "WLNavigationViewNode.h"

@interface WLNavigationNode () <WLBarButtonItemNodeDelegate>

@property (nonatomic) NSMutableArray * childNodeStack;
@property (nonatomic) WLNavigationViewNode *topNode;

@end

@implementation WLNavigationNode

- (instancetype)initWithRootNode:(WLNavigationViewNode *)rootNode size:(CGSize)size
{
    NSAssert(rootNode != nil, @"root node could not be nil");
    self = [self initWithColor:[SKColor yellowColor] size:size];
    if (self) {
        
        NSMutableArray *nodeStack = [NSMutableArray arrayWithCapacity:2];
        [nodeStack addObject:rootNode];
        self.childNodeStack = nodeStack;
        self.anchorPoint = CGPointZero;
        self.topNode = rootNode;
        rootNode.navigationNode = self;
        rootNode.position = CGPointMake(rootNode.size.width / 2, rootNode.size.height / 2);
        [self addChild:rootNode];
        
        SKTexture *barTexture = [SKTexture textureWithImageNamed:@"nav_bg"];
        WLNavigationBarNode *navigationBar = [WLNavigationBarNode spriteNodeWithTexture:barTexture size:CGSizeMake(size.width, 44)];
        navigationBar.anchorPoint = CGPointZero;
        navigationBar.centerRect = CGRectMake(128, 29, 1, 1);
        navigationBar.position = CGPointMake(0, size.height - navigationBar.size.height);
        self.navigationBar = navigationBar;
        [self addChild:navigationBar];
        
        WLBarButtonItemNode *backItem = [WLBarButtonItemNode spriteNodeWithImageNamed:@"nav_back" delegate:self];
        backItem.anchorPoint = CGPointZero;
        backItem.position = CGPointMake(5, (navigationBar.size.height - backItem.size.height) / 2);
        backItem.alpha = 0;
        self.backItem = backItem;
        [navigationBar addChild:backItem];
        
        if (rootNode.rightBarButtonItem) {
            self.rightBarButtonItem = rootNode.rightBarButtonItem;
            rootNode.rightBarButtonItem.position = CGPointMake(self.navigationBar.size.width - rootNode.rightBarButtonItem.size.width - 5, (self.navigationBar.size.height - rootNode.rightBarButtonItem.size.height) / 2);
            [self.navigationBar addChild:rootNode.rightBarButtonItem];
        }
    }
    
    return self;
}

- (void)pushNode:(WLNavigationViewNode *)node
{
    self.backItem.alpha = 1;
    
    [self.childNodeStack addObject:node];
    node.position = CGPointMake(self.size.width + node.size.width / 2, node.size.height / 2);
    [self addChild:node];
    SKAction *move = [SKAction moveByX:-self.size.width y:0 duration:0.25];
    SKAction *complete = [SKAction runBlock:^{
        self.topNode = node;
    }];
    SKAction *fade = [SKAction fadeOutWithDuration:0.25];
    [self.topNode runAction:fade];
    [node runAction:[SKAction sequence:@[move, complete]]];
}

- (void)popNode
{
    [self.childNodeStack removeObject:self.topNode];
    if (self.childNodeStack.count == 1) {
        self.backItem.alpha = 0;
    }
    WLNavigationViewNode *node = [self.childNodeStack lastObject];
    SKAction *move = [SKAction moveByX:self.size.width y:0 duration:0.25];
    SKAction *fade = [SKAction fadeInWithDuration:0.25];
    SKAction *complete = [SKAction runBlock:^{
        [self.topNode removeFromParent];
        self.topNode = node;
    }];
    [self.topNode runAction:move];
    [node runAction:[SKAction sequence:@[fade, complete]]];
}

#pragma mark - bar button item delegate
- (void)buttonItemDidTapped:(WLBarButtonItemNode *)buttonItem
{
    [self popNode];
}

@end
