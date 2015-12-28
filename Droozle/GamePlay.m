//
//  GamePlay.m
//  Droozle
//
//  Created by Jason Deckman on 9/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

@synthesize dimx, dimy, timeInterval;
@synthesize gameState, gameData, criticalState;
@synthesize placeMode, wordLogic;

- (CGFloat)setUp:(Board*)brd :(CGRect)frm {
   
    CGFloat buffer = frm.size.width*PIECE_BUFFER;
    CGFloat pw;
    
    dimy = 6;
    
    pw = (frm.size.width-buffer)/dimy;
    
    dimx = (int)(frm.size.height/pw);
    
    board = brd;
    
    maxVal = 100;
    
    wordLogic = [[WordLogic alloc] init];
    [wordLogic initLetters];
    
    [self setUpPointsForLevel];
    
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
    
    timeInterval = TIME_FACTOR;
    
    criticalState = NO;
    
    [wordLogic initWordTypesForLevel:gameData.level];
}

- (void)rowOfValues {

    NSMutableArray *vals = [[NSMutableArray alloc] initWithCapacity:dimx];
    
    for(int i=0; i<dimy; i++)
        [vals addObject:[wordLogic getLetter]];
    
    [vals addObject:[wordLogic getType]];
    
    [board addBottomRow:vals];
}

- (void)incrementTimer {

    ++gameData.timer;
}

- (NSString*)getARandomLetter {

    return [wordLogic randomLetter];
}

- (BOOL)checkWord: (NSString*)word :(NSString*)wrdType {
    
    return [wordLogic isWord:word inCategory:wrdType];
}

- (void)updateScore:(int)newPoints {

    gameData.score += newPoints*gameData.level;
}

- (void)deconstruct {
    
    [wordLogic deconstruct];
}

- (NSString*)getPointsForLevel:(uint)level {

    if(level >= [pointsForLevel count]) {
     
        NSString *points = [pointsForLevel objectAtIndex:[pointsForLevel count]-1];
        
        return points;
    }
    
    return [pointsForLevel objectAtIndex:level];
}

- (void)setUpPointsForLevel {
    
    pointsForLevel = [[NSMutableArray alloc] initWithObjects:
                      @"500",
                      @"500",
                      @"1500",
                      @"5000",
                      @"25000",
                      @"50000",
                      @"100000",
                      @"150000",
                      @"200000",
                      @"250000",
                      @"350000",
                      @"500000",
                      @"750000",
                      @"1000000",
                      nil];
}

@end
