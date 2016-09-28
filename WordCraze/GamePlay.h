//
//  GamePlay.h
//  Droozle
//
//  Created by Jason Deckman on 9/26/15.
//  Copyright © 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "WordLogic.h"

#define TIME_FACTOR 15

#define MAX_BOMBS 3
#define MAX_NUKES 1

#define FULL_WORD_BONUS 15
#define BOMB_BONUS_SCORE 30
#define NUKE_BONUS_SCORE 70

@interface GamePlay : NSObject {
    
    int dimx;
    int dimy;

    int maxVal;
    int timeInterval;
    
    Board *board;
    
    GameState gameState;
    GameData gameData;
    PlaceMode placeMode;
  //  MoveType moveType;
    
    WordLogic *wordLogic;
    
    NSMutableArray *pointsForLevel;
}

@property (nonatomic) int dimx;
@property (nonatomic) int dimy;

@property (nonatomic) int timeInterval;

@property (nonatomic) GameState gameState;
@property (nonatomic) GameData gameData;
@property (nonatomic) PlaceMode placeMode;
//@property (nonatomic) MoveType moveType;

@property (nonatomic, strong) WordLogic *wordLogic;

@property (nonatomic) BOOL criticalState;

- (CGFloat)setUp:(Board*)brd :(CGRect)frm :(BOOL)iPad;

- (void)rowOfValues;
- (void)newGame;
- (void)incrementTimer;
- (void)resetTimer;

- (int)updateScore:(int)newPoints;

- (NSString*)getARandomLetter;
- (NSString*)getPointsForLevel:(uint)level;
- (NSString*)getRandomCategoryForLevel:(int)level;

- (BOOL)checkWord:(NSString*)word :(NSString*)wrdType;

- (void)checkDifficulty;
- (void)loadDefaults;
- (void)deconstruct;

- (void)decrementNumBombs;
- (void)incrementBombs;

- (void)decrementNumNukes;
- (void)incrementNukes;

- (void)levelUp;

- (void)generateRandomLetterOfCount:(int)numLetters :(NSMutableArray*)letters;
- (uint)getRowDelayForNumRows:(uint)nrows;

@end
