//
//  WLNavigationNode.m
//  WuLin
//
//  Created by huangluyang on 14-1-11.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLNavigationNode.h"
#import "WLSpriteViewNode.h"

@interface WLNavigationNode () <WLBarButtonItemNodeDelegate>

@property (nonatomic) NSMutableArray * childNodeStack;
@property (nonatomic) WLSpriteViewNode *topNode;

@end

@implementation WLNavigationNode

- (instancetype)initWithRootNode:(WLSpriteViewNode *)rootNode size:(CGSize)size
{
    NSAssert(rootNode != nil, @"root node could not be nil");
    self = [self initWithColor:[SKColor grayColor] size:size];
    if (self) {
        
        NSMutableArray *nodeStack = [NSMutableArray arrayWithCapacity:2];
        [nodeStack addObject:rootNode];
        self.childNodeStack = nodeStack;
        self.anchorPoint = CGPointZero;
        self.topNode = rootNode;
        rootNode.navigationNode = self;
        [self addChild:rootNode];
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)kWLNodeDidAddToParentNotification object:rootNode];
        
        SKTexture *barTexture = [SKTexture textureWithImageNamed:@"nav_bg"];
        WLNavigationBarNode *navigationBar = [WLNavigationBarNode spriteNodeWithTexture:barTexture size:CGSizeMake(size.width, 44)];
        navigationBar.anchorPoint = CGPointZero;
//        navigationBar.centerRect = CGRectMake(128, 29, 1, 1);
        navigationBar.position = CGPointMake(0, size.height - navigationBar.size.height);
        navigationBar.zPosition = 1;
        self.navigationBar = navigationBar;
        [self addChild:navigationBar];
        
        WLBarButtonItemNode *backItem = [WLBarButtonItemNode spriteNodeWithImageNamed:@"nav_back" delegate:self];
        backItem.anchorPoint = CGPointZero;
        backItem.position = CGPointMake(10, (navigationBar.size.height - backItem.size.height) / 2);
        backItem.alpha = 0;
        self.backItem = backItem;
        [navigationBar addChild:backItem];
        
        if (rootNode.rightBarButtonItem) {
            self.rightBarButtonItem = rootNode.rightBarButtonItem;
            rootNode.rightBarButtonItem.position = CGPointMake(self.navigationBar.size.width - rootNode.rightBarButtonItem.size.width - 10, (self.navigationBar.size.height - rootNode.rightBarButtonItem.size.height) / 2);
            [self.navigationBar addChild:rootNode.rightBarButtonItem];
        }
        
        self.alpha = 0;
    }
    
    return self;
}

- (void)pushNode:(WLSpriteViewNode *)node
{
    self.backItem.alpha = 1;
    
    [self.childNodeStack addObject:node];
    node.position = CGPointMake(self.size.width, 0);
    node.navigationNode = self;
    [self addChild:node];
    [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)kWLNodeDidAddToParentNotification object:node];
    SKAction *move = [SKAction moveByX:-self.size.width y:0 duration:0.18];
    SKAction *complete = [SKAction runBlock:^{
        self.topNode = node;
    }];
//    SKAction *fade = [SKAction fadeOutWithDuration:0.18];
//    [self.topNode runAction:fade];
    [node runAction:[SKAction sequence:@[move, complete]]];
    
    SKAction *back = [SKAction moveByX:-self.size.width y:0 duration:0.18];
    [self.topNode runAction:back];
}

- (void)popNode
{
    [self.childNodeStack removeObject:self.topNode];
    if (self.childNodeStack.count == 1) {
        self.backItem.alpha = 0;
    }
    WLSpriteViewNode *node = [self.childNodeStack lastObject];
    SKAction *move = [SKAction moveByX:self.size.width y:0 duration:0.18];
    SKAction *complete = [SKAction runBlock:^{
        [self.topNode removeFromParent];
        self.topNode = nil;
        self.topNode = node;
        self.topNode.navigationNode.navigationBar.title = self.topNode.title;
    }];
    SKAction *back = [SKAction moveByX:self.size.width y:0 duration:0.18];
    [node runAction:back];
    [self.topNode runAction:[SKAction sequence:@[move, complete]]];
}

- (void)show
{
    SKAction *showAction = [SKAction fadeInWithDuration:0.1];
    [self runAction:showAction withKey:@"show"];
}

- (void)dismiss
{
    SKAction *dismissAction = [SKAction fadeOutWithDuration:0.1];
    SKAction *moveDown = [SKAction moveByX:0 y:-self.size.height duration:0.1]; /*需要先移走再移除，否则移除后node得不到响应*/
    SKAction *moveAway = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[dismissAction, moveDown, moveAway]] withKey:@"dismiss"];
}

#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DLog(@"touch began");
}

#pragma mark - bar button item delegate
- (void)buttonItemDidTapped:(WLBarButtonItemNode *)buttonItem
{
    [self popNode];
}

@end
