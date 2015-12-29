//
//  ViewController.m
//  Droozle
//
//  Created by Jason Deckman on 9/4/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

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
        
        uint nRowsOcc = [board numRowsOccupied];
        
        if(nRowsOcc < 1) [gamePlay rowOfValues];
        
        else {
            
            if(nRowsOcc >= board.dimx - 2) [display animateAlertView];
            
            else [display hideAlertView];
            
            if(!animating && gamePlay.gameData.timer % gamePlay.timeInterval == 0) {

                if([board shiftRowsUp] == YES) {
                
                    gamePlay.gameState = gameOver;
                }
            
                else
                
                    [gamePlay rowOfValues];
            }
        }
        
        [gamePlay incrementTimer];
    }
    
    if(gamePlay.gameState == levelUp) {
        
        [board clearBoard];
        [display updateLevelValues];
        
        gamePlay.gameState = gameRunning;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState == gameMenu) {
    
        if(touch.view == display.menuView) {
            
            location = [touch locationInView:display.menuView];
            
            if(CGRectContainsPoint(display.menuView.nwGameLabel.frame, location)) {
                
                [self setUpNewGame];
            }
            else {
                
                display.menuView.hidden = YES;
                [board unHideOccupiedPieces];
                
                gamePlay.gameState = gameRunning;
            }
        }
        
        else {
            
            display.menuView.hidden = YES;
            [board unHideOccupiedPieces];
            
            gamePlay.gameState = gameRunning;
        }
    }
    
    else if(gamePlay.gameState == gameRunning) {
        
        if(touch.view == display.boardView && gamePlay.placeMode == freeState) {
            
            touchedSpace = [board getSpaceFromPoint:location];
            
            if(touchedSpace.refPiece) {
                
                NSString *word = [board makeWordFromRow:touchedSpace.iind];
                NSString *type = touchedSpace.piece.text;
                
                animating = YES;
                
                if([gamePlay checkWord:word :type]) {
                    
                    int newScore = [gamePlay updateScore:[board sumRow:touchedSpace.iind]];
                    
                    [board getPiecesInRow:display.piecesToAnimate :touchedSpace.iind];
                    
                    [display animateScore:newScore];
                    [display makePiecesFlash:NO];
                    
                    [self performSelector:@selector(eliminateRowFromBoard) withObject:nil afterDelay:0.4];
                }
                
                else {
                    
                    int newScore = [gamePlay updateScore:-1.0*[board sumRow:touchedSpace.iind]];
                    
                    [board getPiecesInRow:display.piecesToAnimate :touchedSpace.iind];
                    
                    [display animateScore:newScore];
                    [display makePiecesFlash:YES];
                    
                    [self performSelector:@selector(resetRow) withObject:nil afterDelay:0.4];
                }
            }
            
            else if(touchedSpace.isOccupied) {
                
                gamePlay.placeMode = swipeMove;
                [display configureFloatPiece:touchedSpace];
            }
        }
        
        else if(touch.view == display.bottomBar && gamePlay.placeMode == freeState) {
            
            if(CGRectContainsPoint(display.menuBar.frame, location)) {
                
                gamePlay.gameState = gameMenu;
                
                display.menuView.hidden = NO;
                
                [board hideOccupiedPieces];
                [self.view bringSubviewToFront:display.menuView];
        
            }
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.addPiece.frame, location)) {
                
                gamePlay.placeMode = addMove;
            }
        }
    }
    
    else if(gamePlay.gameState == gameOver) {
     
        if(touch.view == display.menuView) {
            
            location = [touch locationInView:display.menuView];
            
            if(CGRectContainsPoint(display.menuView.nwGameLabel.frame, location)) {
                
                [self setUpNewGame];
            }
            else {
                
                display.menuView.hidden = YES;
                [board unHideOccupiedPieces];
            }
        }
        
        else {
            
            display.menuView.hidden = YES;
            [board unHideOccupiedPieces];
        }

        if(touch.view == display.bottomBar && display.menuView.hidden == YES) {
            
            if(CGRectContainsPoint(display.menuBar.frame, location)) {
                
                display.menuView.hidden = NO;
                
                [board hideOccupiedPieces];
                [self.view bringSubviewToFront:display.menuView];
                
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
        
        else if(gamePlay.placeMode == addMove) {
            
            [display changeAddPieceLoc:location];
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState == gameRunning) {
      
        if(gamePlay.placeMode == swipeMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
         //   if([selectedSpace isNearestNearestNbrOf:touchedSpace]) {
             if(selectedSpace != NULL && !selectedSpace.refPiece) {
                 
                rowNew = selectedSpace.iind;
                rowOrig = touchedSpace.iind;
                
                if(selectedSpace.isOccupied) {
                    
                    NSString *val = selectedSpace.value;
                    uint pVal = selectedSpace.pointValue;
                    
                    tmpColor = selectedSpace.piece.backgroundColor;
                    
                    selectedSpace.piece.backgroundColor = touchedSpace.piece.backgroundColor;
                    selectedSpace.pointValue = touchedSpace.pointValue;
                    
                    touchedSpace.pointValue = pVal;
                    touchedSpace.piece.backgroundColor = tmpColor;
                    
                    selectedSpace.value = touchedSpace.value;
                    selectedSpace.piece.text = selectedSpace.value;
                    
                  //  [board removePiece:touchedSpace];
                    touchedSpace.value = val;
                    touchedSpace.piece.text = touchedSpace.value;
                    
                    if(![board isCategoryRow:touchedSpace.iind] && touchedSpace.pointValue == 0)
                        [board removePiece:touchedSpace];
                }
                
                else if([selectedSpace isNearestNearestNbrOf:touchedSpace]){
                    
                    selectedSpace.value = touchedSpace.value;
                    selectedSpace.piece.text = selectedSpace.value;
                    
                    [board addPiece:selectedSpace.iind :selectedSpace.jind :touchedSpace.value];
                    
                    touchedSpace.piece.backgroundColor = display.addPiece.backgroundColor;
                    touchedSpace.piece.text = @"";
                    
                    touchedSpace.value = @"";
                    touchedSpace.pointValue = 0;
                    
                    //[board removePiece:touchedSpace];
                }
            }
            
            display.floatPiece.hidden = YES;
            touchedSpace = NULL;
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == addMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
            if(selectedSpace.isOccupied && !selectedSpace.refPiece) {
                
                selectedSpace.value = display.addPiece.text;
                selectedSpace.piece.text = display.addPiece.text;
                
                selectedSpace.piece.backgroundColor = display.addPiece.backgroundColor;
                selectedSpace.pointValue = 0;
                
              //  display.addPiece.text = [gamePlay getARandomLetter];
                display.addPiece.text = @"";
            }
            
            else {
                
                
            }
            
            [display resetAddPiece];
            touchedSpace = NULL;
            gamePlay.placeMode = freeState;
        }
    }
}

- (void)addPiecesToView {
    
    Space *space;
    
    for(int i=0; i<gamePlay.dimx; i++) {
        
        space = [board getRefSpaceFromIndex:i];
        [self.view addSubview:space.piece];
        
        for(int j=0; j<gamePlay.dimy; j++) {
            
            space = [board getSpaceForIndices:i :j];
            
            [self.view addSubview:space.piece];
            [self.view addSubview:space.backPiece];
            
            [self.view bringSubviewToFront:space.piece];
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
    [board initBoard:boardFrm :gamePlay.dimx :gamePlay.dimy :0.00075*self.view.frame.size.width :buffer :gamePlay.wordLogic];
    
    [self addPiecesToView];
    
    Space *space = [board getSpaceForIndices:0 :0];
    
    [display setUpFloatPieces:space.piece.frame];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1/1 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    display.gamePlay = gamePlay;
    
    display.addPiece.text = @""; //[gamePlay getARandomLetter];
    
    [display updateScore];
    [display updateLevelValues];
    
    [gamePlay rowOfValues];
    
    animating = NO;
}

- (void)eliminateRowFromBoard {
    
    [display resetAnimatedPieces];
    
    [board eliminateRow:touchedSpace.iind];
    
    animating = NO;
}

- (void)resetRow {

    [display resetAnimatedPieces];
    
    animating = NO;
}

- (void)setUpNewGame {
    
    [board deconstruct];
    [display deconstruct];
    [gamePlay deconstruct];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate resetApp];
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
