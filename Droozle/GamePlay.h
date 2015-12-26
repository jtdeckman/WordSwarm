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

@interface GamePlay : NSObject {
    
    int dimx;
    int dimy;
    
    int maxVal;
    
    Board *board;
    
    GameState gameState;
    GameData gameData;
    PlaceMode placeMode;
    
    WordLogic *wordLogic;
}

@property (nonatomic) int dimx;
@property (nonatomic) int dimy;

@property (nonatomic) GameState gameState;
@property (nonatomic) GameData gameData;
@property (nonatomic) PlaceMode placeMode;

- (CGFloat)setUp:(Board*)brd :(CGRect)frm;

- (void)rowOfValues;
- (void)newGame;
- (void)incrementTimer;

- (NSString*)getARandomLetter;

- (BOOL)checkWord:(NSString*)word :(NSString*)wrdType;

- (void)deconstruct;

@end
