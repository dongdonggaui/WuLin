//
//  WLGrapicsUtilitites.h
//  WuLin
//
//  Created by huangluyang on 13-12-30.
//  Copyright (c) 2013年 huangluyang. All rights reserved.
//


/* Generate a random float between 0.0f and 1.0f. */
#define WL_RANDOM_0_1() (arc4random() / (float)(0xffffffffu))

/* The assets are all facing Y down, so offset by pi half to get into X right facing. */
#define WL_POLAR_ADJUST(x) x + (M_PI * 0.5f)


/* Load an array of WLDataMap or WLTreeMap structures for the given map file name. */
void *WLCreateDataMap(NSString *mapName);

/* Distance and coordinate utility functions. */
CGFloat WLDistanceBetweenPoints(CGPoint first, CGPoint second);
CGFloat WLRadiansBetweenPoints(CGPoint first, CGPoint second);
CGPoint WLPointByAddingCGPoints(CGPoint first, CGPoint second);
CGFloat WLLengthOfVector(CGPoint theVector);
CGPoint WLUnitVector(CGPoint theVector);
CGFloat WLRadianBetweenVectorA(CGPoint vectorA, CGPoint vectorB);
CGPoint WLDefaultUnitVector();
CGPoint WLVectorMinus(CGPoint vectorA, CGPoint vectorB);

/* Load the named frames in a texture atlas into an array of frames. */
NSArray *WLLoadFramesFromAtlas(NSString *atlasName, NSString *baseFileName, int numberOfFrames);

/* Run the given emitter once, for duration. */
void WLRunOneShotEmitter(SKEmitterNode *emitter, CGFloat duration);


/* Define structures that map exactly to 4 x 8-bit ARGB pixel data. */
#pragma pack(1)
typedef struct {
    uint8_t bossLocation, wall, goblinCaveLocation, heroSpawnLocation;
} WLDataMap;

typedef struct {
    uint8_t unusedA, bigTreeLocation, smallTreeLocation, unusedB;
} WLTreeMap;
#pragma pack()

typedef WLDataMap *WLDataMapRef;
typedef WLTreeMap *WLTreeMapRef;


/* Category on NSValue to make it easy to access the pointValue/CGPointValue from iOS and OS X. */
@interface NSValue (WLAdditions)
- (CGPoint)WL_CGPointValue;
+ (instancetype)WL_valueWithCGPoint:(CGPoint)point;
@end


/* Category on SKEmitterNode to make it easy to load an emitter from a node file created by Xcode. */
@interface SKEmitterNode (WLAdditions)
+ (instancetype)WL_emitterNodeWithEmitterNamed:(NSString *)emitterFileName;
@end
