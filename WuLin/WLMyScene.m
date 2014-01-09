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

@interface WLMyScene ()

@property (nonatomic) WLMenPai *world;

@end

@implementation WLMyScene

- (void)dealloc
{
    self.world = nil;
    
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
    
    WLMenPai *world = [WLMenPai spriteNodeWithImageNamed:@"test_menpai_base"];
    world.userInteractionEnabled = YES;
    self.world = world;
    [self addNode:world  atWorldLayer:WLSceneLayerGame];
    
    WLButtonNode *button = [WLButtonNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(100, 40)];
    button.name = @"button";
    button.userInteractionEnabled = YES;
    button.position = CGPointMake(10 + button.size.width / 2, self.size.height - 30 - button.size.height / 2);
    [self addNode:button atWorldLayer:WLSceneLayerHUD];
    
    WLButtonNode *button1 = [WLButtonNode spriteNodeWithColor:[SKColor greenColor] size:CGSizeMake(100, 40)];
    button1.name = @"button1";
    button1.userInteractionEnabled = YES;
    button1.position = CGPointMake(10 + button1.size.width / 2, self.size.height - 30 - button1.size.height / 2 - button.size.height - 10);
    [self addNode:button1 atWorldLayer:WLSceneLayerHUD];
    
    WLButtonNode *button2 = [WLButtonNode spriteNodeWithColor:[SKColor blueColor] size:CGSizeMake(100, 40)];
    button2.name = @"button2";
    button2.title = @"显示网格";
    button2.selectedTitle = @"隐藏网格";
    button2.userInteractionEnabled = YES;
    button2.position = CGPointMake(10 + button2.size.width / 2, self.size.height - 30 - button2.size.height / 2 - button.size.height - 10 - button1.size.height - 10);
    [self addNode:button2 atWorldLayer:WLSceneLayerHUD];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveButtonNotification:) name:(NSString *)WLButtonNodeDidTappedNotification object:nil];
}

- (void)didReceiveButtonNotification:(NSNotification *)notification
{
    WLButtonNode *button = notification.object;
    if ([button.name isEqualToString:@"button"]) {
        WLBuildingNode *building = [WLBuildingNode buildingWithShadowImageName:@"test_selected" xTileCount:2 yTileCount:2];
        building.userInteractionEnabled = YES;
        building.size = CGSizeMake(building.size.width, building.size.height);
        [self.world addNode:building atWorldLayer:WLWorldLayerBelowCharacter];
        [building moveToPointInMathCoord:CGPointMake(1, 1)];
        NSLog(@"(x, y) = %@", NSStringFromCGPoint(building.position));
    } else if ([button.name isEqualToString:@"button1"]) {
        [WLGridUtility generateTilesInNode:self.world withGridWidth:9 gridHeight:9];
    } else if ([button.name isEqualToString:@"button2"]) {
        if (button.isSelected) {
            [self.world showGrid];
        } else {
            [self.world hideGrid];
        }
    }
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
