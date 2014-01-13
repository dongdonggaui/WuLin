//
//  WLMyScene.m
//  WuLin
//
//  Created by huangluyang on 14-1-8.
//  Copyright (c) 2014年 huangluyang. All rights reserved.
//

#import "WLMyScene.h"
#import "WLButtonNode.h"
#import "WLBuildingNode.h"
#import "WLGridManager.h"
#import "JSTileMap.h"
#import "WLNavigationNode.h"
#import "WLStoreViewNode.h"
#import "WLStoreDetailViewNode.h"

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
    button.position = CGPointMake(10, self.size.height - 20 - button.size.height);
    [self addNode:button atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *button1 = [WLButtonNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(100, 40)];
    button1.name = @"button1";
    button1.title = @"建造设施";
    button1.userInteractionEnabled = YES;
    button1.position = CGPointMake(10, self.size.height - 20 - button1.size.height - button.size.height - 10);
    [self addNode:button1 atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *button2 = [WLButtonNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(100, 40)];
    button2.name = @"button2";
    button2.title = @"显示网格";
    button2.selectedTitle = @"隐藏网格";
    button2.userInteractionEnabled = YES;
    button2.position = CGPointMake(10, self.size.height - 20 - button2.size.height - button.size.height - 10 - button1.size.height - 10);
    [self addNode:button2 atSceneLayer:WLSceneLayerTop];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveButtonNotification:) name:(NSString *)WLButtonNodeDidTappedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveSelectedTobeBuildNotification:) name:(NSString *)kWLDidSelectedTobeBuildNotification object:nil];
}

- (void)didReceiveSelectedTobeBuildNotification:(NSNotification *)notification
{
    WLButtonNode *button = (WLButtonNode *)notification.object;
    if ([button.name isEqualToString:@"temple"]) {
        WLBuildingNode *temple = [[WLBuildingNode alloc] initWithName:@"temple"];
        if (temple) {
//            temple.position = CGPointMake((self.menpai.size.width - temple.frame.size.width) / 2, (self.menpai.size.height - temple.frame.size.height) / 2);
            [temple moveToPointInMathCoord:CGPointMake(0, 0)];
            [self.menpai addNode:temple atWorldLayer:WLWorldLayerAboveGrid];
            DLog(@"temple frame = %@", NSStringFromCGRect(temple.frame));
        }
    }
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
        WLStoreViewNode *node = [WLStoreViewNode spriteNodeWithColor:[SKColor clearColor] size:self.size];
        WLNavigationNode *nav = [[WLNavigationNode alloc] initWithRootNode:node size:self.size];
        nav.navigationBar.title = @"商店";
        [self addNode:nav atSceneLayer:WLSceneLayerHUD];
        [nav show];
        
        
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
