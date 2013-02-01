//
//  HelloWorldLayer.m
//  t1a
//
//  Created by Ricardo Quesada on 1/31/13.
//  Copyright Ricardo Quesada 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer


// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {

		[self registerShader];
	
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//
		// Background images that are going to be affected by the grey layer
		//
		for( int i=0; i<200;i++) {
			CCSprite *sp = [CCSprite spriteWithFile:@"Icon.png"];
			CGPoint p = ccp( s.width * CCRANDOM_0_1(), s.height * CCRANDOM_0_1());
			[sp setPosition:p];
			
			CGPoint dst = ccp( 200 * CCRANDOM_0_1(), 200 * CCRANDOM_0_1());
			CCMoveBy *move = [CCMoveBy actionWithDuration:5 * CCRANDOM_0_1() position:dst];
			CCActionInterval *back = [move reverse];
			CCSequence *seq = [CCSequence actions:move, back, nil];
			[sp runAction:[CCRepeatForever actionWithAction:seq]];
			
			[self addChild:sp];
		}
		
		//
		// Grey Layer
		//
		CCLayerColor *layer = [CCLayerColor layerWithColor:ccc4(0, 0, 0, 255)]; // the color is not important. Is ignored by the shader
		[self addChild:layer];
		layer.ignoreAnchorPointForPosition = NO;
		layer.position = ccp(s.width/2, s.height/2);

		// Shader that uses gl_LastFragData. Creates a fullscreen grey effect.
		// Much faster than using Render-To-Texture techniques,
		// and also much easier to use
		layer.shaderProgram = [[CCShaderCache sharedShaderCache] programForKey:@"greyShader"];

		id scale = [CCScaleBy actionWithDuration:3 scale:0.1];
		id scale_back = [scale reverse];
		id sequence = [CCSequence actions:scale, scale_back, nil];
		[layer runAction:[CCRepeatForever actionWithAction:sequence]];
		
		
		//
		// Foreground images that are NOT affected by the grey layer
		//
		CCSprite *sp = [CCSprite spriteWithFile:@"Icon.png"];
		CGPoint p = ccp( s.width/2, s.height/2);
		[sp setPosition:p];
		[self addChild:sp];
	}
	return self;
}

-(void) registerShader
{
	CCGLProgram *program = [[CCGLProgram alloc] initWithVertexShaderFilename:@"shader_test.vsh"
													  fragmentShaderFilename:@"shader_test.fsh"];
	
	[program addAttribute:kCCAttributeNamePosition index:kCCVertexAttrib_Position];
	[program addAttribute:kCCAttributeNameTexCoord index:kCCVertexAttrib_TexCoords];
	
	[program link];
	[program updateUniforms];
	
	[[CCShaderCache sharedShaderCache] addProgram:program forKey:@"greyShader"];

	[program autorelease];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
