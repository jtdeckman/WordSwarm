//
//  GamePlay.m
//  Droozle
//
//  Created by Jason Deckman on 9/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

@synthesize dimx, dimy;
@synthesize gameState, gameData;

- (void)setUp:(Board*)brd :(CGRect)frm {
   
    CGFloat pw;
    
    dimy = 5;
    
    pw = frm.size.width/dimy;
    
    dimx = (int)frm.size.height/pw;
    
    board = brd;
    
    maxVal = 100;
    
    [self newGame];
}

- (void)newGame {

    gameData.level = 1;
    gameData.timer = 0;
    gameData.lives = 3;
    gameData.score = 0;
    gameData.highScore = 0;
    
    gameState = gameRunning;
}

- (void)rowOfValues {

    NSMutableArray *vals = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    NSNumber *value;
    
    for(int i=0; i<dimy; i++) {
        value = [NSNumber numberWithInt:arc4random() % maxVal];
        [vals addObject:value];
    }
    
    value = [NSNumber numberWithInt:maxVal];
    [vals addObject:value];
    
    [board addBottomRow:vals];
}

- (void)incrementTimer {

    ++gameData.timer;
}

@end
