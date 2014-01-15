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

@interface WLMyScene () <WLButtonNodeDelegate>

@property (nonatomic) WLMenPai *menpai;

@end

static NSString *kWLMySceneStoreButton = @"store_button";
static NSString *kWLMySceneFriendButton = @"store_button";
static NSString *kWLMySceneSettingButton = @"store_button";

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
    
    WLButtonNode *button1 = [WLButtonNode buttonWithImageName:@"store_btn_icon" backgroundImageName:@"store_btn_bg" title:@"商店" scale:1 delegate:self];
    button1.name = kWLMySceneStoreButton;
    button1.userInteractionEnabled = YES;
    button1.position = CGPointMake(self.size.width - button1.size.width - 10, 10);
    [self addNode:button1 atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *friendButton = [WLButtonNode buttonWithImageName:@"friend_btn_icon" backgroundImageName:@"store_btn_bg" title:nil scale:0.5 delegate:self];
    friendButton.name = kWLMySceneFriendButton;
    friendButton.userInteractionEnabled = YES;
    friendButton.position = CGPointMake(self.size.width - friendButton.size.width - 10, 10 + button1.size.height + 10);
    [self addNode:friendButton atSceneLayer:WLSceneLayerTop];
    
    WLButtonNode *settingButton = [WLButtonNode buttonWithImageName:@"setting_btn_icon" backgroundImageName:@"store_btn_bg" title:nil scale:0.5 delegate:self];
    settingButton.name = kWLMySceneSettingButton;
    settingButton.userInteractionEnabled = YES;
    settingButton.position = CGPointMake(self.size.width - friendButton.size.width - 10, 10 + button1.size.height + 10 + friendButton.size.height + 10);
    [self addNode:settingButton atSceneLayer:WLSceneLayerTop];
    
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
            [temple moveToPointInGrid:CGPointMake(10, 10)];
            [self.menpai addNode:temple atWorldLayer:WLWorldLayerAboveGrid];
            DLog(@"temple frame = %@", NSStringFromCGRect(temple.frame));
        }
    }
}

- (void)didReceiveButtonNotification:(NSNotification *)notification
{
    WLButtonNode *button = notification.object;
    if ([button.name isEqualToString:@"button"]) {
//        WLBuildingNode *building = [WLBuildingNode buildingWithShadowImageName:@"test_selected" xTileCount:2 yTileCount:2];
//        building.userInteractionEnabled = YES;
//        building.size = CGSizeMake(building.size.width, building.size.height);
//        [self.menpai addNode:building atWorldLayer:WLWorldLayerAboveGrid];
//        [building moveToPointInGrid:CGPointMake(1, 1)];
//        NSLog(@"(x, y) = %@", NSStringFromCGPoint(building.position));
        self.menpai.xScale = 1;
        self.menpai.yScale = 1;
        [WLGridManager sharedInstance].currentRate = 0.5;
        
    } else if ([button.name isEqualToString:@"button1"]) {
//        WLStoreViewNode *node = [WLStoreViewNode spriteNodeWithColor:[SKColor clearColor] size:self.size];
        
        
        
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

#pragma mark - button delegate
- (void)buttonNodeDidTapped:(WLButtonNode *)buttonNode
{
    if ([buttonNode.name isEqualToString:kWLMySceneStoreButton]) {
        WLStoreViewNode *node = [WLStoreViewNode storeWithImageName:@"store_bg" size:self.size];
        node.centerRect = CGRectMake(40.0 / 100.0, 67.0 / 154.0, 4.0 / 100.0, 20.0 / 154.0);
        WLNavigationNode *nav = [[WLNavigationNode alloc] initWithRootNode:node size:self.size];
        nav.navigationBar.title = @"商店";
        [self addNode:nav atSceneLayer:WLSceneLayerHUD];
        [nav show];
    }
}

@end
