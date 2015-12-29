//
//  Constants.h
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef Droozle_Constants_h
#define Droozle_Constants_h

#define WIDTH_FACT 1.00
#define HEIGHT_FACT 1.00
#define TOPBAR_V_FACT 0.2

#define BUTTON_WIDTH_FACT 0.25
#define BUTTON_HEIGHT_FACT 0.1
#define BUTTON_SPACING_FACT 0.1

#define SPACING_FACT 0.025
#define PIECE_BUFFER 0.2
#define LINE_THICK_FACT 0.015

#define DIMX 10
#define DIMY 10

#define FONT_FACT 0.4

#define MAX_NEARBY_NEIGHBORS 8

typedef struct {
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    
} JDColor;

typedef struct {
    
    int level;
    int timer;
    int lives;
    int score;
    int highScore;
    
    uint numBombs;
    uint numKnockouts;
    
} GameData;

typedef enum : NSUInteger {
    
    gameRunning,
    gamePaused,
    gameOver,
    gameMenu,
    winState,
    winMenu,
    preWin,
    newGame,
    howToPlay,
    levelUp
    
} GameState;



typedef enum : NSUInteger {
    
    placeMove,
    splitMove,
    addMove,
    overtakeMove
    
} MoveType;

typedef enum : NSUInteger {
    
    freeState,
    pieceSelected,
    spaceSelected,
    overTake,
    placeTile,
    swipeMove,
    
} PlaceMode;

#endif
