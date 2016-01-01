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

    [self loadDefaults];
    
    gameState = gameRunning;
    placeMode = freeState;
    
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

- (int)updateScore:(int)newPoints {

    int newScore = newPoints;
    
    if(gameData.gamePlay == FREE_PLAY) {
        
        gameData.score += newScore;
        
        return newScore;
    }
    
    if(newScore > gameData.highestWordScore) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        gameData.highestWordScore = newScore;
        
        [defaults setInteger:newScore forKey:@"highestWordScore"];
        [defaults synchronize];
    }
    
    gameData.score += newScore*gameData.level;
    
    NSString *pointsForNextLevel = [self getPointsForLevel:gameData.level + 1];
    
    if(gameData.score >= [pointsForNextLevel intValue]) {
        
        gameState = levelUp;
        gameData.level += 1;
        
        [self incrementBombs];
        
        [wordLogic initWordTypesForLevel:gameData.level];
    }
    
    [self checkHighScores];
    
    return newScore;
}

- (NSString*)getPointsForLevel:(uint)level {

    if(level >= [pointsForLevel count]) {
     
        NSString *points = [pointsForLevel objectAtIndex:[pointsForLevel count]-1];
        
        return points;
    }
    
    return [pointsForLevel objectAtIndex:level];
}

- (void)loadDefaults {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    gameData.level = 1;
    gameData.score = 0;
    
    gameData.gamePlay = (uint)[defaults integerForKey:@"gamePlay"];
    gameData.difficulty = (int)[defaults integerForKey:@"difficulty"];
    
    gameData.highScore = (int)[defaults integerForKey:@"highScore"];
    gameData.highestLevel = (int)[defaults integerForKey:@"highestLevel"];
    gameData.highestWordScore = (int)[defaults integerForKey:@"highestWordScore"];
    
    gameData.numBombs = (int)[defaults integerForKey:@"numBombs"];
    
    if(gameData.difficulty > 0)
        timeInterval = TIME_FACTOR - 3;
    else
        timeInterval = TIME_FACTOR;
    
    if(gameData.gamePlay == FREE_PLAY) {
    
        if(gameData.difficulty > 1)
            gameData.level = -2;
        else
            gameData.level = -1;
    }
    
    [defaults synchronize];
}

- (void)checkHighScores {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(gameData.score > gameData.highScore) {
        
        gameData.highScore = gameData.score;
        
        [defaults setInteger:gameData.score forKey:@"highScore"];
        [defaults synchronize];
    }
    
    if(gameData.gamePlay == LEVELED_PLAY && gameData.level > gameData.highestLevel) {
        
        gameData.highestLevel = gameData.level;
        
        [defaults setInteger:gameData.level forKey:@"highestLevel"];
        [defaults synchronize];
    }
}

- (void)setUpPointsForLevel {
    
    pointsForLevel = [[NSMutableArray alloc] initWithObjects:
                      
                      @"25",
                      @"25",
                      @"100",
                      @"500",
                      @"750",
                      @"1500",
                      @"5000",
                      @"10000",
                      @"20000",
                      @"40000",
                      @"60000",
                      @"80000",
                      @"100000",
                      @"125000",
                      @"150000",
                      @"200000",
                      nil];
}

- (void)checkDifficulty {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    gameData.difficulty = (int)[defaults integerForKey:@"difficulty"];
    
    if(gameData.difficulty > 0)
        timeInterval = TIME_FACTOR - 3;
    else
        timeInterval = TIME_FACTOR;
}

- (void)decrementNumBombs {
    
    --gameData.numBombs;
}

- (void)incrementBombs {
    
    if(gameData.numBombs < MAX_BOMBS)
        ++gameData.numBombs;
}

- (uint)getRowDelayForNumRows:(uint)nrows {

    if(nrows == 0 || nrows == 1)
        return 3;
    else if(nrows < 4)
        return timeInterval;
    
    return timeInterval;
}

- (void)deconstruct {
    
    [wordLogic deconstruct];
    [pointsForLevel removeAllObjects];
    
    wordLogic = nil;
    pointsForLevel = nil;
}

@end
