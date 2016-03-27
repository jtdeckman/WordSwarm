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

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:NO];
    
    if(prevViewSettings) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        if((int)[defaults integerForKey:@"gamePlay"] != gamePlay.gameData.gamePlay)
            [self setUpNewGame];
        
        [gamePlay checkDifficulty];
        
        prevViewSettings = NO;
    }
}

- (void)gameLoop {
    
    if(gamePlay.gameState == gameRunning && !animating) {
        
      
        uint nRowsOcc = [board numRowsOccupied];
        uint timeInterval;
        
        if(nRowsOcc < 1) {
            
            animating = YES;
            [gamePlay rowOfValues];
            
            [board getPiecesInRow:display.piecesToAnimate :bottomRow :YES :0];
            [board hidePointsLabelInRow:bottomRow];
            
            [display animatePiecesToBottomRow:0.7f];
            
            [self performSelector:@selector(rowAddAnimatingOff) withObject:nil afterDelay:0.8f];
        }
        
        else {
            
            timeInterval = [gamePlay getRowDelayForNumRows:nRowsOcc];
            
            [display checkAlertView:nRowsOcc];
            
            if(!animating && !swiping && gamePlay.gameData.timer % timeInterval == 0) {
            
                [gamePlay resetTimer];
                
                if([board shiftRowsUp] == YES) {
                
                    gamePlay.gameState = gameOver;
                    
                    [display.animations animateTextBox2:2.0f :0.90*self.view.frame.size.height :0.3*self.view.frame.size.height :0.4f :@"Game Over"];
                    
                    [board hideOccupiedPieces];
                    [display hideAlertView];
                }
            
                else {
                    
                    [gamePlay rowOfValues];
                    
                    animating = YES;
                    [gamePlay rowOfValues];
                    
                    [board getPiecesInRow:display.piecesToAnimate :bottomRow :YES :0];
                    [board hidePointsLabelInRow:bottomRow];
               
                    [display animatePiecesToBottomRow:0.7f];
                    
                    [self performSelector:@selector(rowAddAnimatingOff) withObject:nil afterDelay:0.8f];
                }
            }
        }
        
        [gamePlay incrementTimer];
    }
    
    if(gamePlay.gameState == levelUp) {
        
        if(!animating) {
            
            animating = YES;
            
            display.levelLabel.hidden = YES;
            
            [board hideAllBackPieces];
            [board hideOccupiedPieces];
            
            [display hideAlertView];
            [display animateLevelTile:1.0];
        
            display.level.text = @"";
            
            [self performSelector:@selector(setUpForNextLevel) withObject:nil afterDelay:1.1];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    if(gamePlay.gameState == gameMenu && !animating) {
    
       // animating = YES;
        
        if(touch.view == display.menuView) {
            
            location = [touch locationInView:display.menuView];
            
            if(CGRectContainsPoint(display.menuView.nwGameLabel.frame, location)) {
                
                [self setUpNewGame];
            }
            
            else if(CGRectContainsPoint(display.menuView.statsLabel.frame, location)) {
                
                StatsView *statsView = [[StatsView alloc] init];
                [self presentViewController:statsView animated:NO completion:nil];
            }
            
            else if(CGRectContainsPoint(display.menuView.settingsLabel.frame, location)) {
                
                prevViewSettings = YES;
                
                SettingsViewController *settingsView = [[SettingsViewController alloc] init];
                [self presentViewController:settingsView animated:NO completion:nil];
                
                settingsView = nil;
            }

            else if(CGRectContainsPoint(display.menuView.howToLabel.frame, location)) {
                
                HowToScreen *howToScreen = [[HowToScreen alloc] init];
                [self presentViewController:howToScreen animated:NO completion:nil];
                
                howToScreen = nil;
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
    
    else if(gamePlay.gameState == gameRunning && !animating) {
        
        if(touch.view == display.boardView && gamePlay.placeMode == freeState) {
            
            touchedSpace = [board getSpaceFromPoint:location];
            
            if(touchedSpace.isOccupied) {
                
                //swiping = YES;
                
                //gamePlay.placeMode = swipeMove;
        
                //[display configureFloatPiece:touchedSpace];
                
                if(touchedSpace == highlightedSpace1) {
                    
                    highlightedSpace1 = nil;
                    [touchedSpace setBackhighlightClear];
                }
                
                else if(highlightedSpace1 == nil) {
                    
                    highlightedSpace1 = touchedSpace;
                    [highlightedSpace1 setBackhighlightRed];
                }
                
                else if(highlightedSpace2 == nil) {
                    
                    highlightedSpace2 = touchedSpace;
                    [highlightedSpace2 setBackhighlightBlue];
                    
                    gamePlay.placeMode = swapMove;
                }
            }
            
            else
                [self clearHighlightedSpaces];
        }
        
        if(touch.view == display.bottomBar && gamePlay.placeMode == freeState) {
            
            [self clearHighlightedSpaces];
            
            if(CGRectContainsPoint(display.menuBar.frame, location)) {
                
                gamePlay.gameState = gameMenu;
                
                display.menuView.hidden = NO;
                
                [board hideOccupiedPieces];
                [self.view bringSubviewToFront:display.menuView];
            }
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.addPiece.frame, location)) {
                
                swiping = YES;
                gamePlay.placeMode = addMove;
            }
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.bombPiece.frame, location)) {
                
                swiping = YES;
                gamePlay.placeMode = bombMove;
            }
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.nukePiece.frame, location)) {
                
                swiping = YES;
                gamePlay.placeMode = nukeMove;
            }

        }
    }
    
    else if(gamePlay.gameState == gameOver) {
     
        if(touch.view == display.menuView) {
            
            location = [touch locationInView:display.menuView];
            
            if(CGRectContainsPoint(display.menuView.nwGameLabel.frame, location)) {
                
                [self setUpNewGame];
            }
            
            else if(CGRectContainsPoint(display.menuView.statsLabel.frame, location)) {
                
                StatsView *statsView = [[StatsView alloc] init];
                [self presentViewController:statsView animated:NO completion:nil];
            }

            else if(CGRectContainsPoint(display.menuView.settingsLabel.frame, location)) {
                
                prevViewSettings = YES;
                
                SettingsViewController *settingsView = [[SettingsViewController alloc] init];
                [self presentViewController:settingsView animated:NO completion:nil];
                
                settingsView = nil;
            }

            else if(CGRectContainsPoint(display.menuView.howToLabel.frame, location)) {
                
                HowToScreen *howToScreen = [[HowToScreen alloc] init];
                [self presentViewController:howToScreen animated:NO completion:nil];
                
                howToScreen = nil;
            }

            else {
                
                display.menuView.hidden = YES;
                [board unHideOccupiedPieces];
            }
        }
        
        else {
            
            display.animations.textBox2.hidden = YES;
            [display.animations.textBox2 removeFromSuperview];

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
    
    if(gamePlay.gameState ==  gameRunning) { //&& !animating) {
        
        if(gamePlay.placeMode == swipeMove) {
            
           // [display changeFloatPieceLoc:location];
        }
        
        else if(gamePlay.placeMode == addMove) {
            
            [display changeAddPieceLoc:location];
        }
        
        else if(gamePlay.placeMode == bombMove) {
            
            [display changeBombPieceLoc:location];
        }
        
        else if(gamePlay.placeMode == nukeMove) {
            
            [display changeNukePieceLoc:location];
        }

        else {
            
            [display changeFloatPieceLoc:location];
        }
        
        swiping = YES;
    }
    else {
        
        swiping = NO;
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    swiping = NO;
    
    if(gamePlay.gameState == gameRunning && !animating) {
      
        if(gamePlay.placeMode == swapMove) {
            
            [self clearHighlightedSpaces];
            
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == addMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
            if(selectedSpace.isOccupied && !selectedSpace.refPiece) {
                
                selectedSpace.value = display.addPiece.text;
                selectedSpace.piece.text = display.addPiece.text;
                
                selectedSpace.piece.backgroundColor = display.addPiece.backgroundColor;
                //selectedSpace.pointValue *= -1;
                selectedSpace.pointValue = 0;
                selectedSpace.pointsLabel.text = @"";//[NSString stringWithFormat:@"%d",selectedSpace.pointValue];
                
                display.addPiece.text = @"";
            }
            
            else {
                
            }
            
            [display resetAddPiece];
            touchedSpace = NULL;
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == bombMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
            if(selectedSpace.isOccupied && !selectedSpace.refPiece) {
                
                animating = YES;
                
             //   int newScore = [gamePlay updateScore:[board sumRow:selectedSpace.iind :NO]];
                
                [board getPiecesInRow:display.piecesToAnimate :selectedSpace.iind :NO :0];
                [board hideBackPiecesInRow:selectedSpace.iind];
                [board hideOccupiedPiecesInRow:selectedSpace.iind];
               
                [display makePiecesExplode:1.5 :0.0];
                
                [self performSelector:@selector(eliminateRowFromBoard:) withObject:selectedSpace afterDelay:1.0];
                
                [display resetBombPiece:YES];
            }
            
            else {
                
                [display resetBombPiece:NO];
            }
            
            touchedSpace = NULL;
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == nukeMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
            if(selectedSpace.isOccupied && !selectedSpace.refPiece) {
                
                animating = YES;
                
                [board getAllVisiblePieces:display.piecesToAnimate :NO];
                [board hideAllBackPieces];
                [board hideOccupiedPieces];
                
                [display hideAlertView];
                [display makePiecesExplode:1.5 :0.0];
                
                [self performSelector:@selector(clearBoardAfterAnimationNotWordBar) withObject:nil afterDelay:1.6f];
                
                [display resetNukePiece:YES];
            }
            
            else {
                
                [display resetNukePiece:NO];
            }
            
            touchedSpace = NULL;
            gamePlay.placeMode = freeState;
        }

    }
    
    
    else {
        display.floatPiece.hidden = YES;
        [display resetAddPiece];
    }
}

- (void)addPiecesToView {
    
    Space *space;
    
    for(int i=0; i<gamePlay.dimx; i++) {
        
        for(int j=0; j<gamePlay.dimy; j++) {
            
            space = [board getSpaceForIndices:i :j];
            
            [self.view addSubview:space.piece];
            [self.view addSubview:space.backPiece];
            [self.view addSubview:space.pointsLabel];
        }
    }
}

- (void)setUpViewController {

    CGRect boardFrm;
    
    CGFloat aRatio = self.view.frame.size.width/self.view.frame.size.height;
   
    BOOL iPad = NO;
    
    swiping = NO;
    
    [AppDelegate setUpDefaults];
    
    display = [[Display alloc] init];
    [display initDisplay:self.view.frame :self];
    
    board = [[Board alloc] init];
    gamePlay = [[GamePlay alloc] init];
    
    boardFrm = [display initBoardView:self.view.frame];
    
    if(aRatio > 0.74)
        iPad = YES;
    
    CGFloat buffer = [gamePlay setUp:board :boardFrm :iPad];
    [board initBoard:boardFrm :gamePlay.dimx :gamePlay.dimy :0.00075*self.view.frame.size.width :buffer :gamePlay.wordLogic];
    
    [self addPiecesToView];
    
    Space *space = [board getSpaceForIndices:0 :0];
    
    [display setUpFloatPieces:space.piece.frame];
    
    gameTimer = [NSTimer scheduledTimerWithTimeInterval:1/1 target:self selector:@selector(gameLoop) userInfo:nil repeats:YES];
    
    display.gamePlay = gamePlay;
    
    animating = NO;
    prevViewSettings = NO;
    
    bottomRow = board.dimx - 1;
    
    [display.wordBar setUpForLevel:1];
    display.wordBar.wordCategory = [gamePlay getRandomCategoryForLevel:gamePlay.gameData.level];
    
    [display updateScore];
    [display updateLevelValues];
}

- (void)eliminateRowFromBoard:(Space*)space {
   
    [board eliminateRow:space.iind];
    [self checkWordRow];
 
    animating = NO;
}

- (void)populateWordBarFromRow:(Space*)spaceInRow {

    Space *space;

    CGFloat duration = 0.5f;
    CGFloat delay = 0.0f;
    CGFloat totalTime = 0.0f;
    
    int nletters = [display.wordBar numOccupied];
    int maxSize = [display.wordBar lettersInLevel];
    
    for(uint j=0; j<board.dimy && nletters < maxSize; j++) {
            
        space = [board getSpaceForIndices:spaceInRow.iind:j];
        
        if(space.backPieceVal > 1 && ![space.value isEqualToString:@""]) {
            
            [display.wordBar animatePieceToSpace:space.piece :duration :delay :nletters];
            [display.wordBar addLetterToBox:space.value withDelay:duration+0.1];
            
            ++nletters;
         
            totalTime += duration;
        }
    }
    
    [self performSelector:@selector(eliminateRowFromBoard:) withObject:spaceInRow afterDelay:totalTime];
}

- (void)checkWordRow {
    
    if(display.wordBar.boxesFilled) {
        
        NSString *word = [display.wordBar makeWordFromLetters];
        
        if([gamePlay checkWord:word :display.wordBar.wordCategory]) {
            
            if(gamePlay.gameData.gamePlay == FREE_PLAY)
                [self performSelector:@selector(clearLettersWithDelay) withObject:nil afterDelay:0.51];
            else
                gamePlay.gameState = levelUp;
        }
        
        else {
    
            uint topUnOccupiedRow = board.dimx - [board numRowsOccupied] - 1;
            
            if(topUnOccupiedRow < 1) {
            
                gamePlay.gameState = gameOver;
            }
            
            else {
                
                NSMutableArray *pieceLocations = [[NSMutableArray alloc] initWithCapacity:board.dimy];
                
                if([word length] > board.dimy)
                    word = [word substringToIndex:board.dimy-1];
                
                [board getPiecesInRow:pieceLocations :topUnOccupiedRow :NO :(uint)[word length]];
                
                [display.animations animateTextBox4:1.0f :0.125*self.view.frame.size.height :0.75*display.boardView.frame.origin.y :0.0f :[NSString stringWithFormat:@"Not a %@!", display.wordBar.wordCategory]];
                
                for(uint i=0; i<[word length]; i++)
                    [display.wordBar animatePieceBackToBoard:(UILabel*)pieceLocations[i] :1.0 :0.0 :i];
                
                [display.wordBar makeBarPiecesFlash:1.0];
                
                animating = YES;
                
                [self performSelector:@selector(addWordToTopOfStack:) withObject:word afterDelay:1.1];
            }
        }
    }
    
    [display updateScore];
}

- (void)addWordToTopOfStack:(NSString*)word {
 
    [board addWordToTopUnOccupiedRow:word :display.wordBar.wordCategory];
    animating = NO;
}

- (void)resetRow {

    [board unHideBackPiecesInRow:touchedSpace.iind];
    [board unHidePiecesInRow:touchedSpace.iind];
    
    animating = NO;
}

- (void)clearLettersWithDelay {

    [display.wordBar clearLetters];
}

- (void)setUpNewGame {
    
    [board deconstruct];
    [display deconstruct];
    [gamePlay deconstruct];

    touchedSpace = nil;
    gameTimer = nil;
    alertTimer = nil;
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    [appDelegate resetApp];
}

- (void)updateGameScoreAfterDelay:(NSNumber*)newScore {

    [gamePlay updateScore:(int)[newScore integerValue]];
    [display updateScore];
}

- (void)setUpForNextLevel {
    
    [gamePlay levelUp];
    
    animating = NO;
  
    [board clearBoard];
    [display resetForNextLevel];
    
    gamePlay.gameState = gameRunning;
}

- (void)rowAddAnimatingOff {

    [board unHidePiecesInRow:bottomRow];
    animating = NO;
}

- (void)turnAnimatingOff {
    
}

- (void)clearBoardAfterAnimation {

    [board clearBoard];
    [display.wordBar clearLetters];
    
    animating = NO;
}

- (void)clearBoardAfterAnimationNotWordBar {
    
    [board clearBoard];
    
    animating = NO;
}
           
- (void)clearHighlightedSpaces {

    [highlightedSpace1 setBackhighlightClear];
    [highlightedSpace2 setBackhighlightClear];
    
    highlightedSpace1 = nil;
    highlightedSpace2 = nil;
}

- (void)saveDefaults {
    
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
