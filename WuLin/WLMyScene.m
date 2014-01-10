//
//  WLMyScene.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMyScene.h"
#import "WLMenPai.h"
#import "WLButtonNode.h"
#import "WLBuildingNode.h"
#import "WLGridUtility.h"
#import "JSTileMap.h"

@interface WLMyScene ()

@property (nonatomic) WLMenPai *menpai;

@end

@implementation WLMyScene

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Init
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.name = @"MyScene";
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    WLMenPai *world = [WLMenPai spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(600, 400)];
    world.userInteractionEnabled = YES;
    self.menpai = world;
    [self addNode:world  atSceneLayer:WLSceneLayerWorld];
    
    WLButtonNode *button = [WLButtonNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(100, 40)];
    button.name = @"button";
    button.userInteractionEnabled = YES;
    button.position = CGPointMake(10 + button.size.width / 2, self.size.height - 30 - button.size.height / 2);
    [self addNode:button atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *button1 = [WLButtonNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(100, 40)];
    button1.name = @"button1";
    button1.userInteractionEnabled = YES;
    button1.position = CGPointMake(10 + button1.size.width / 2, self.size.height - 30 - button1.size.height / 2 - button.size.height - 10);
    [self addNode:button1 atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *button2 = [WLButtonNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(100, 40)];
    button2.name = @"button2";
    button2.title = @"显示网格";
    button2.selectedTitle = @"隐藏网格";
    button2.userInteractionEnabled = YES;
    button2.position = CGPointMake(10 + button2.size.width / 2, self.size.height - 30 - button2.size.height / 2 - button.size.height - 10 - button1.size.height - 10);
    [self addNode:button2 atSceneLayer:WLSceneLayerTop];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveButtonNotification:) name:(NSString *)WLButtonNodeDidTappedNotification object:nil];
}

- (void)didReceiveButtonNotification:(NSNotification *)notification
{
    WLButtonNode *button = notification.object;
    if ([button.name isEqualToString:@"button"]) {
        WLBuildingNode *building = [WLBuildingNode buildingWithShadowImageName:@"test_selected" xTileCount:2 yTileCount:2];
        building.userInteractionEnabled = YES;
        building.size = CGSizeMake(building.size.width, building.size.height);
        [self.menpai addNode:building atWorldLayer:WLWorldLayerAboveGrid];
        [building moveToPointInMathCoord:CGPointMake(1, 1)];
        NSLog(@"(x, y) = %@", NSStringFromCGPoint(building.position));
    } else if ([button.name isEqualToString:@"button1"]) {
        SKSpriteNode *node = [SKSpriteNode spriteNodeWithColor:[SKColor blueColor] size:self.size];
        node.position = CGPointMake(node.size.width / 2, node.size.width / 2);
        node.alpha = 0;
        SKAction *action = [SKAction fadeInWithDuration:0.5];
        [self addNode:node atSceneLayer:WLSceneLayerHUD];
        [node runAction:action];
        
    } else if ([button.name isEqualToString:@"button2"]) {
        if (button.isSelected) {
//            [self.world showGrid];
        } else {
//            [self.world hideGrid];
        }
    }
}



#pragma mark - Private Methods


#pragma mark - Touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
 
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
