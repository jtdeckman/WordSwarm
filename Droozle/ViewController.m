//
//  ViewController.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUpViewController];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)gameLoop {
    
    if(gamePlay.gameState == gameRunning) {
     
        int intervalFactor = (int)(TIME_FACTOR*(1/gamePlay.gameData.level));
        
        if(gamePlay.gameData.timer % intervalFactor == 0) {

            if([board shiftRowsUp] == YES) {
                
                gamePlay.gameState = gameOver;
            }
            else {
                [gamePlay rowOfValues];
            }
        }
        
        [gamePlay incrementTimer];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState == gameRunning) {
        
        if(touch.view == display.boardView && gamePlay.placeMode == freeState) {
            
            touchedSpace = [board getSpaceFromPoint:location];
            
            if(touchedSpace.isOccupied) {
                
                gamePlay.placeMode = swipeMove;
                [display configureFloatPiece:touchedSpace :self.view];
            }
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState ==  gameRunning) {
        
        if(gamePlay.placeMode == swipeMove) {
            
            [display changeFloatPieceLoc:location];
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState == gameRunning) {
      
        if(gamePlay.placeMode == swipeMove) {
            
            display.floatPiece.hidden = YES;
            
            gamePlay.placeMode = freeState;
        }
    }
}

- (void)addPiecesToView {
    
    Space *space;
    
    for(int i=0; i<gamePlay.dimx; i++) {
        
        space = [board getRefSpaceFromIndex:i];
        [self.view addSubview:space.piece];
        
        space = [board getSumSpaceFromIndex:i];
        [self.view addSubview:space.piece];
        
        for(int j=0; j<gamePlay.dimy; j++) {
            space = [board getSpaceForIndices:i :j];
            [self.view addSubview:space.piece];
        }
    }
}

- (void)setUpViewController {

    CGRect boardFrm;

    display = [[Display alloc] init];
    [display initDisplay:self.view.frame :self];
    
    board = [[Board alloc] init];
    gamePlay = [[GamePlay alloc] init];
    
    boardFrm = [display initBoardView:self.view.frame];
    
    CGFloat buffer = [gamePlay setUp:board :boardFrm];
    [board initBoard:boardFrm :gamePlay.dimx :gamePlay.dimy :0 :buffer];
    
    [self addPiecesToView];
    
    Space *space = [board getSpaceForIndices:0 :0];
    
    [display setUpFloatPieces:space.piece.frame :self.view];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1/1 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
}

@end
