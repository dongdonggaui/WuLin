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
        WLMenPai *world = [WLMenPai spriteNodeWithImageNamed:@"test_bg"];
        world.userInteractionEnabled = YES;
        world.anchorPoint = CGPointZero;
        self.world = world;
        [self addNode:world atWorldLayer:WLSceneLayerGame];
        
        WLButtonNode *button = [WLButtonNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(100, 40)];
        button.userInteractionEnabled = YES;
        button.position = CGPointMake(10 + button.size.width / 2, self.size.height - 30 - button.size.height / 2);
        [self addNode:button atWorldLayer:WLSceneLayerHUD];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    [super didMoveToView:view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveButtonNotification:) name:(NSString *)WLButtonNodeDidTappedNotification object:nil];
}

- (void)didReceiveButtonNotification:(NSNotification *)notification
{
    WLBuildingNode *building = [WLBuildingNode buildingWithShadowImageName:@"test_selected" xTileCount:2 yTileCount:2];
    building.userInteractionEnabled = YES;
    building.size = CGSizeMake(building.size.width, building.size.height);
    [self.world addNode:building atWorldLayer:WLWorldLayerAboveCharacter];
    [building moveToPointInMathCoord:CGPointMake(1, 1)];
    NSLog(@"(x, y) = %@", NSStringFromCGPoint(building.position));
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
