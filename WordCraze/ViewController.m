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
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.frame = CGRectMake(0, 0, 40, 40);
    spinner.center = self.view.center;
    
    [self.view addSubview:spinner];
    
    [self startSpinner];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:NO];
    
    if(!initView) {
        
        [self setUpViewController];
        initView = YES;
    }
    
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
            
            [topSpaces removeAllObjects];
            [newLetters removeAllObjects];
            
            [board getTopUnOccupiedSpaces:topSpaces];
            [gamePlay generateRandomLetterOfCount:(int)[topSpaces count] :newLetters];
            
            [board addSpacesToBoard:topSpaces :newLetters];
        }
        
        else {
            
          //  [self checkWordRow];
            
            timeInterval = [gamePlay getRowDelayForNumRows:nRowsOcc];
            
            [display checkAlertView:nRowsOcc];
            
          //  [board refreshBackPieces];
            
            if(!animating && !swiping && gamePlay.gameData.timer % timeInterval == 0) {
            
                [gamePlay resetTimer];
                
                [self clearHighlightedSpaces];
                [self clearCurrentWord];
                
                if([board topRowOccupied] == YES) {
                
                    gamePlay.gameState = gameOver;
                    
                    animating = YES;
                    
                    [display.animations animateTextBox2:2.0f :0.90*self.view.frame.size.height :0.3*self.view.frame.size.height :0.4f :@"Game Over"];
                  
                    [board hideOccupiedPieces];
                    [display hideAlertView];
                }
            
                else {
                    
                    [topSpaces removeAllObjects];
                    [newLetters removeAllObjects];
                    [display.piecesToAnimate removeAllObjects];
                    
                    [board getTopUnOccupiedSpaces:topSpaces];
                    [gamePlay generateRandomLetterOfCount:(int)[topSpaces count] :newLetters];
                    
                    [board addSpacesToBoard:topSpaces :newLetters];
                    
                    for(Space* space in topSpaces)
                        [display.piecesToAnimate addObject:space.piece];
                    
                    animating = YES;
                    
                    [board hidePointsLabelForSpacesInArray:topSpaces];
                    
                    [display animatePiecesToBottomRow:1.0f :YES];
                    
                    [self performSelector:@selector(rowAddAnimatingOff) withObject:nil afterDelay:1.1f];
                    
                    [board refreshBackPieces];
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

- (void)howToPlayInitView {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if(!howToSeen && ![defaults boolForKey:@"howToScreenSeen"]) {
        
        HowToScreenInit *howToScreen = [[HowToScreenInit alloc] init];
        [self presentViewController:howToScreen animated:NO completion:nil];
        
        howToScreen = nil;
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
                
                [self startSpinner];
                
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
        
        [self clearCurrentWord];
        
        if(touch.view == display.boardView && gamePlay.placeMode == freeState) {
            
            touchedSpace = [board getSpaceFromPoint:location];
            
            if(touchedSpace.isOccupied) {
                
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
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.bombPiece.frame, location)) {
                
                gamePlay.placeMode = bombMove;
            }
            
            else if(gamePlay.placeMode == freeState && CGRectContainsPoint(display.nukePiece.frame, location)) {
                
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
            
            if(touch.view == display.boardView) {
            
                Space *currentSpace = [board getSpaceFromPoint:location];
            
                if(currentSpace != nil) {
                    
                    [currentSpace setBackhighlightBlue];
            
                    if(currentSpace != touchedSpace) {
                        touchedSpace = currentSpace;
                
                        if(touchedSpace.piece.text != nil && ![touchedSpace.piece.text isEqualToString:@""])
                        [currentWord appendString:touchedSpace.piece.text];
                
                        [highlightedPieces addObject:touchedSpace];
                    }
                }
            }
            
            else {
                
                gamePlay.gameState = freeState;
                [self clearCurrentWord];
            }
        }
        
        else if(gamePlay.placeMode == bombMove) {
            
            [display changeBombPieceLoc:location];
        }
        
        else if(gamePlay.placeMode == nukeMove) {
            
            [display changeNukePieceLoc:location];
        }

        else if((highlightedSpace1 != nil || gamePlay.placeMode == swapMove) && touch.view == display.boardView) {
            
            [self clearHighlightedSpaces];
            [touchedSpace setBackhighlightBlue];
            
            if(touchedSpace.piece.text != nil && ![touchedSpace.piece.text isEqualToString:@""])
                [currentWord appendString:touchedSpace.piece.text];
            
            [highlightedPieces addObject:touchedSpace];
            
            gamePlay.placeMode = swipeMove;

        }
        else {
            
           // gamePlay.placeMode = freeState;
        }
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    swiping = NO;
    
    if(gamePlay.gameState == gameRunning && !animating) {
      
        if(gamePlay.placeMode == swapMove) {
            
            [self swapPieces:highlightedSpace1 :highlightedSpace2];
            [self clearHighlightedSpaces];
            
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == swipeMove) {
            
            if(currentWord.length > 1 && [gamePlay checkWord:currentWord :@"Word"]) {
                
                animating = YES;
                
             //   [self performSelector:@selector(populateWordBarFromSpaces) withObject:touchedSpace afterDelay:0.4f];
                
                [self performSelector:@selector(shiftColumnsDownAfterDelay) withObject:touchedSpace afterDelay:0.4f];
                
                int wordScore  = [self calcScoreFromSelectedPieces];
                
                [gamePlay updateScore:wordScore];
                
                [board getPiecesInRow:display.piecesToAnimate :touchedSpace.iind :YES :0];
                
                [display animateScore:wordScore];
            }
            
            else {
                
                [self clearCurrentWord];
            }
            
            gamePlay.placeMode = freeState;
        }
        
        else if(gamePlay.placeMode == bombMove) {
            
            Space *selectedSpace = [board getSpaceFromPoint:location];
            
            if(selectedSpace.isOccupied && !selectedSpace.refPiece) {
                
                animating = YES;
                
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
            [self clearCurrentWord];
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
    
  //  boardFrm = [display initBoardView:self.view.frame];
    
    boardFrm = display.boardView.frame;
    
    if(aRatio > 0.74)
        iPad = YES;
    
    CGFloat buffer = [gamePlay setUp:board :boardFrm :iPad];
    [board initBoard:boardFrm :gamePlay.dimx :gamePlay.dimy :0.00075*self.view.frame.size.width :buffer :gamePlay.wordLogic :iPad];
    
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
    
    highlightedPieces = [[NSMutableArray alloc] initWithCapacity:board.dimx*board.dimy];
    highlightLabels = [[NSMutableArray alloc] initWithCapacity:board.dimx*board.dimy];
    
    topSpaces = [[NSMutableArray alloc] initWithCapacity:board.dimy+1];
    newLetters = [[NSMutableArray alloc] initWithCapacity:board.dimy+1];
    
    currentWord = [[NSMutableString alloc] initWithString:@""];
    
    [self stopSpinner];
}

- (void)eliminateRowFromBoard:(Space*)space {
   
    [board eliminateRow:space.iind];
   // [self checkWordRow];
 
    animating = NO;
}

- (void)populateWordBarFromSpaces {

    Space *space;

    CGFloat duration = 0.5f;
    CGFloat delay = 0.0f;
    CGFloat totalTime = 0.0f;
    
    int nletters = [display.wordBar numOccupied];
    int maxSize = [display.wordBar lettersInLevel];
  
    for(int j=0; j<highlightedPieces.count; j++) {
        
        if(nletters < maxSize) {
                
            space = [highlightedPieces objectAtIndex:j];
        
            if(space.backPieceVal > 1 && ![space.value isEqualToString:@""]) {
                    
                [display.wordBar animatePieceToSpace:space.piece :duration :delay :nletters];
                [display.wordBar addLetterToBox:space.value withDelay:duration+0.1];
                
                ++nletters;
         
                totalTime += duration;
            }
        }
    }
    
    [self performSelector:@selector(checkWordRow) withObject:nil afterDelay:totalTime];
}

- (void)shiftColumnsDownAfterDelay {
    
   // [self checkWordRow];
    [self performSelector:@selector(shiftColumns) withObject:nil afterDelay:0.51];
   }

- (void)shiftColumns {
    
    Space *space;
    
    for(int i=0; i<highlightedPieces.count; i++) {
        space = highlightedPieces[i];
        [board removePiece:space];
    }
    
    for(int i=0; i<board.dimx; i++)
        [board shiftColumnsDown];
    
    [board moveColumns];
    
    [self clearCurrentWord];
    
    [self turnAnimationOff];
}

- (void)checkWordRow {
    
    [display checkAlertView:[board numRowsOccupied]];
    
    if([display.wordBar boxesFilled]) {
        
        NSString *word = [display.wordBar makeWordFromLetters];
        
        if([gamePlay checkWord:word :display.wordBar.wordCategory]) {
            
            if(gamePlay.gameData.gamePlay == FREE_PLAY) {
                [self performSelector:@selector(clearLettersWithDelay) withObject:nil afterDelay:0.51];
            }
            else
                gamePlay.gameState = levelUp;
        }
        
        else {
            
            if([board topRowOccupied]) {
            
                gamePlay.gameState = gameOver;
                
                animating = YES;
                
                [display.animations animateTextBox2:2.0f :0.90*self.view.frame.size.height :0.3*self.view.frame.size.height :0.4f :@"Game Over"];
                
                [board hideOccupiedPieces];
                [display hideAlertView];
            }
            
            else {
                
                animating = YES;
                
                [display.wordBar makeBarPiecesFlash:1.5];
                [self performSelector:@selector(turnAnimationOff) withObject:nil afterDelay:1.6];
            }
        }
    }
    
    [display updateScore];
}

- (void)turnAnimationOff {

    animating = NO;
    [board refreshBackPieces];
}

- (void)addWordToTopOfStack:(NSString*)word {
 
   // [board addWordToTopUnOccupiedRow:word :display.wordBar.wordCategory];
  //  animating = NO;
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
    
    highlightedPieces = nil;
    highlightLabels = nil;
    
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

    [board unHidePointsLabelForSpaces:topSpaces];
    animating = NO;
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

- (void)swapPieces:(Space*)spc1 :(Space*)spc2 {

    rowNew = spc1.iind;
    rowOrig = spc2.iind;
    
    NSString *val = spc1.value;
        
    int pVal = spc1.pointValue;
        
    tmpColor = spc1.piece.backgroundColor;
        
    spc1.piece.backgroundColor = touchedSpace.piece.backgroundColor;
    spc1.pointValue = spc2.pointValue;
        
    if(spc2.pointValue == 0)
        spc1.pointsLabel.text = @"";
    else
        spc1.pointsLabel.text = [NSString stringWithFormat:@"%d",spc2.pointValue];
        
    spc2.pointValue = pVal;
    spc2.piece.backgroundColor = tmpColor;
        
    if(pVal == 0)
        spc2.pointsLabel.text = @"";
    else
        spc2.pointsLabel.text = [NSString stringWithFormat:@"%d",pVal];
        
    spc1.value = spc2.value;
    spc1.piece.text = spc1.value;
        
    spc2.value = val;
    spc2.piece.text = spc2.value;
}

- (int)calcScoreFromSelectedPieces {

    int score = 0;
    
    for(Space *space in highlightedPieces)
        score += space.pointValue;
    
    return score;
}

- (void)clearHighlightedSpaces {

    [highlightedSpace1 setBackhighlightClear];
    [highlightedSpace2 setBackhighlightClear];
    
    highlightedSpace1 = nil;
    highlightedSpace2 = nil;
}

- (void)clearCurrentWord {

    [board clearAllBackPieces];
    [highlightedPieces removeAllObjects];
    
    [currentWord setString:@""];
}

- (void)startSpinner {
    
    spinner.hidden = NO;
    [self.view bringSubviewToFront:spinner];
    
    [spinner startAnimating];
}

- (void)stopSpinner {
    
    spinner.hidden = YES;
    [spinner stopAnimating];
}

- (void)saveDefaults {
    
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

-(BOOL)shouldAutorotate {
    
    return NO;
}

@end
