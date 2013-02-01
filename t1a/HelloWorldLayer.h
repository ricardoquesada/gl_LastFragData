//
//  HelloWorldLayer.h
//  t1a
//
//  Created by Ricardo Quesada on 1/31/13.
//  Copyright Ricardo Quesada 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

-(void) registerShader;

@end
