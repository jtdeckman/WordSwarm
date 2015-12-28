//
//  Colors.m
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Colors.h"

@implementation Colors

@synthesize topBarBackgroundColor, boardViewBackgroundColor;
@synthesize bottomBarBackgroundColor, scoreColor, levelColor;

- (void)setUpColors {
    
    topBarBackgroundColor.red = 0.2f;
    topBarBackgroundColor.green = 0.4f;
    topBarBackgroundColor.blue = 0.5f;
    
    bottomBarBackgroundColor.red = 0.3f;
    bottomBarBackgroundColor.green = 0.4f;
    bottomBarBackgroundColor.blue = 0.5f;
    
    boardViewBackgroundColor.red = 0.9f;
    boardViewBackgroundColor.green = 0.9f;
    boardViewBackgroundColor.blue = 0.9f;
    
    scoreColor.red = 0.9f;
    scoreColor.green = 0.1f;
    scoreColor.blue = 0.1f;
    
    levelColor.red = 0.55f;
    levelColor.green = 0.7;
    levelColor.blue = 1.0;
}

@end
