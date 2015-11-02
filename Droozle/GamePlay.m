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
@synthesize placeMode;

- (CGFloat)setUp:(Board*)brd :(CGRect)frm {
   
    CGFloat buffer = frm.size.width*PIECE_BUFFER;
    CGFloat pw;
    
    dimy = 6;
    
    pw = (frm.size.width-buffer)/dimy;
    
    dimx = (int)frm.size.height/pw;
    
    board = brd;
    
    maxVal = 100;
    
    [self newGame];
    
    return buffer;
}

- (void)newGame {

    gameData.level = 1;
    gameData.timer = 0;
    gameData.lives = 3;
    gameData.score = 0;
    gameData.highScore = 0;
    
    gameState = gameRunning;
    placeMode = freeState;
}

- (void)rowOfValues {

    NSMutableArray *vals = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    NSNumber *value;
    
    for(int i=0; i<dimy; i++) {
        value = [NSNumber numberWithInt:arc4random() % maxVal];
        [vals addObject:value];
    }
    
    value = [NSNumber numberWithInt:arc4random() % dimy*maxVal + maxVal + arc4random() % 10];
    [vals addObject:value];
    
    [board addBottomRow:vals];
}

- (void)incrementTimer {

    ++gameData.timer;
}

@end
