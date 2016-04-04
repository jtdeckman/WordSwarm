//
//  Display.m
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import "Display.h"

@implementation Display

@synthesize topBar, bottomBar, boardView;
@synthesize floatPiece, addPiece;
@synthesize menuBar, menuView, gamePlay;
@synthesize piecesToAnimate, bombPiece;
@synthesize animations, topOffset, wordBar;
@synthesize levelLabel, nukePiece, level;

- (void)changeFloatPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - floatPieceOffSet.width;
    frm.origin.y = newLoc.y - floatPieceOffSet.height;
    
    frm.size = floatPiece.frame.size;
    
    [floatPiece setFrame:frm];
}

- (void)updateScore {
    
    score.text = [NSString stringWithFormat:@"%d",gamePlay.gameData.score];
    
    if(gamePlay.gameData.numBombs > 0) {
        
        bombPiece.hidden = NO;
        numBombsLabel.hidden = NO;
        numBombsLabel.text = [NSString stringWithFormat:@"x %d",gamePlay.gameData.numBombs];
        
        [rootView bringSubviewToFront:numBombsLabel];
    }
    
    if(gamePlay.gameData.numNukes > 0) {
        
        nukePiece.hidden = NO;
        numNukesLabel.hidden = NO;
        numNukesLabel.text = [NSString stringWithFormat:@"x %d",gamePlay.gameData.numNukes];
        
        [rootView bringSubviewToFront:numNukesLabel];
    }

}

- (void)updateLevelValues {
    
    if(gamePlay.gameData.gamePlay == FREE_PLAY) {
        
        level.text = @"--";
    }
    
    else {
        
        level.text = [NSString stringWithFormat:@"%d",gamePlay.gameData.level];
        
        numBombsLabel.text = [NSString stringWithFormat:@"x %d",gamePlay.gameData.numBombs];
        numNukesLabel.text = [NSString stringWithFormat:@"x %d", gamePlay.gameData.numNukes];
    }
    
    nextScore.text = wordBar.wordCategory;

    if(gamePlay.gameData.numBombs > 0) {
        
        bombPiece.hidden = NO;
        numBombsLabel.hidden = NO;
    }
    
    if(gamePlay.gameData.numNukes > 0) {
        
        nukePiece.hidden = NO;
        numNukesLabel.hidden = NO;
    }
}

- (void)changeAddPieceLoc: (CGPoint)newLoc {

    CGRect frm;
    
    frm.origin.x = newLoc.x - addPieceOffSet.width;
    frm.origin.y = newLoc.y - addPieceOffSet.height;

    frm.size = addPiece.frame.size;
    
    [addPiece setFrame:frm];
}

- (void)changeBombPieceLoc:(CGPoint)newLoc {
    
    CGRect frm;
    
    frm.origin.x = newLoc.x - addPieceOffSet.width;
    frm.origin.y = newLoc.y - addPieceOffSet.height;
    
    frm.size = bombPiece.frame.size;
    
    [bombPiece setFrame:frm];
    
    numBombsLabel.hidden = YES;
}

- (void)changeNukePieceLoc:(CGPoint)newLoc {
    
    CGRect frm;
    
    frm.origin.x = newLoc.x - addPieceOffSet.width;
    frm.origin.y = newLoc.y - addPieceOffSet.height;
    
    frm.size = nukePiece.frame.size;
    
    [nukePiece setFrame:frm];
    
    numNukesLabel.hidden = YES;
}

- (void)configureFloatPiece:(Space*)space {
    
    CGRect frm;
    
    frm.origin.x = space.piece.frame.origin.x;
    frm.origin.y = space.piece.frame.origin.y;
    
    frm.size = space.piece.frame.size;
    
    floatPiece.hidden = NO;
    
    floatPiece.text = space.value;
    floatPiece.layer.borderColor = [[UIColor clearColor] CGColor];
    floatPiece.backgroundColor = space.piece.backgroundColor;
    
    [floatPiece setFrame:frm];
    
    [rootView bringSubviewToFront:floatPiece];
}

- (void)resetAddPiece {

    [addPiece setFrame:baseAddPiece];
}

- (void)resetBombPiece:(BOOL)bombUsed {

    [bombPiece setFrame:baseBombPiece];
    
    if(bombUsed) {
        
        [gamePlay decrementNumBombs];
    
        numBombsLabel.text = [NSString stringWithFormat:@"x %d",gamePlay.gameData.numBombs];
    }
    
    if(gamePlay.gameData.numBombs < 1) {
        
        bombPiece.hidden = YES;
        numBombsLabel.hidden = YES;
    }
    
    else {
            
        bombPiece.hidden = NO;
        numBombsLabel.hidden = NO;
    }
}

- (void)resetNukePiece:(BOOL)nukeUsed {
    
    [nukePiece setFrame:baseNukePiece];
    
    if(nukeUsed) {
        
        [gamePlay decrementNumNukes];
        
        numNukesLabel.text = [NSString stringWithFormat:@"x %d",gamePlay.gameData.numNukes];
    }
    
    if(gamePlay.gameData.numNukes < 1) {
            
        nukePiece.hidden = YES;
        numNukesLabel.hidden = YES;
    }
    
    else {
            
        nukePiece.hidden = NO;
        numNukesLabel.hidden = NO;
    }
}

- (void)animateAlertView {
    
    
    alertView.hidden = NO;
    alertView.alpha = 0.80;
    
    [rootView sendSubviewToBack:alertView];
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        alertView.alpha = 0.25;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            alertView.alpha = 0.80;
            
        } completion:nil];
    }];

}

- (void)hideAlertView {
    
    alertView.hidden = YES;
    
    [rootView setNeedsDisplay];
}

-(void)unhideAlertViewWithAlpha:(CGFloat)alpha {

    CGRect frm = boardView.frame;
    
    frm.origin.y -= wordBar.barBackground.frame.size.height;
    frm.size.height += wordBar.barBackground.frame.size.height;
    
    alertView.hidden = NO;
    alertView.alpha = alpha;
    alertView.frame = frm;
   
    [rootView sendSubviewToBack:alertView];
}

- (void)checkAlertView:(uint)nrows {
    
    if(nrows == gamePlay.dimx)
        [self unhideAlertViewWithAlpha:0.6];//[display animateAlertView];
    
    else if(nrows == gamePlay.dimx - 1)
        [self unhideAlertViewWithAlpha:0.3];
    
    else [self hideAlertView];
    
    [rootView setNeedsDisplay];
}

- (void)makePiecesFlash:(BOOL)wrongWord :(CGFloat)duration {
    
    UILabel *iPiece;
    
    CGFloat dur4 = duration/4.0;
    
    __block UILabel *movePiece;
    
    uint count = (uint)[piecesToAnimate count];
    
    for(uint i=0; i<count; i++) {
        
        movePiece = [animationPieces.pieces objectAtIndex:i];
        
        iPiece = [piecesToAnimate objectAtIndex:i];
        iPiece.hidden = YES;
        
        movePiece.frame = iPiece.frame;
        
        if(!wrongWord)
            movePiece.backgroundColor = [UIColor whiteColor];
        else
            movePiece.backgroundColor = [UIColor colorWithRed:colors.redFlashColor.red
                                                        green:colors.redFlashColor.green
                                                         blue:colors.redFlashColor.blue alpha:0.8f];
        movePiece.hidden = NO;
        movePiece.alpha = 0.8f;
        
        [rootView addSubview:movePiece];
    }
    
    [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        for(int i=0; i<count; i++)
            ((UILabel*)animationPieces.pieces[i]).alpha = 0.2f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            for(int i=0; i<count; i++)
                ((UILabel*)animationPieces.pieces[i]).alpha = 0.8f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                for(int i=0; i<count; i++)
                    ((UILabel*)animationPieces.pieces[i]).alpha = 0.2f;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    for(int i=0; i<count; i++)
                        ((UILabel*)animationPieces.pieces[i]).alpha = 0.8f;
                    
                } completion:^(BOOL finished) {
                    
                    for(int i=0; i<count; i++) {
                        
                        movePiece = [animationPieces.pieces objectAtIndex:i];
                        movePiece.alpha = 1.0;
                        movePiece.hidden = YES;
                        [movePiece removeFromSuperview];
                    }
                }];
            }];
        }];
    }];
}

- (void)makePiecesFlashExt:(BOOL)wrongWord :(CGFloat)duration :(NSMutableArray*)animPieces {
    
    UILabel *iPiece;
    
    CGFloat dur4 = duration/4.0;
    
    __block UILabel *movePiece;
    
    uint count = (uint)[animPieces count];
    
    for(uint i=0; i<count; i++) {
        
        movePiece = [animPieces objectAtIndex:i];
        
        iPiece = [animPieces objectAtIndex:i];
        iPiece.hidden = YES;
        
        movePiece.frame = iPiece.frame;
        
        if(!wrongWord)
            movePiece.backgroundColor = [UIColor whiteColor];
        else
            movePiece.backgroundColor = [UIColor colorWithRed:colors.redFlashColor.red
                                                        green:colors.redFlashColor.green
                                                         blue:colors.redFlashColor.blue alpha:0.8f];
        movePiece.hidden = NO;
        movePiece.alpha = 0.8f;
        
        [rootView addSubview:movePiece];
    }
    
    [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        for(int i=0; i<count; i++)
            ((UILabel*)animPieces[i]).alpha = 0.2f;
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            for(int i=0; i<count; i++)
                ((UILabel*)animPieces[i]).alpha = 0.8f;
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                for(int i=0; i<count; i++)
                    ((UILabel*)animPieces).alpha = 0.2f;
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:dur4 delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    
                    for(int i=0; i<count; i++)
                        ((UILabel*)animPieces[i]).alpha = 0.8f;
                    
                } completion:^(BOOL finished) {
                    
                    for(int i=0; i<count; i++) {
                        
                        movePiece = [animPieces objectAtIndex:i];
                        movePiece.alpha = 1.0;
                        movePiece.hidden = YES;
                        [movePiece removeFromSuperview];
                    }
                }];
            }];
        }];
    }];
}

- (void)makePiecesExplode:(CGFloat)duration :(CGFloat)delay {

    __block UILabel *piece;
    __block UILabel *gamePiece;
    
    __block CGRect frame;
    __block CGPoint rvec;
    __block CGFloat rnum;
    
    for(int i=0; i<[piecesToAnimate count]; i++) {
        
        gamePiece = piecesToAnimate[i];
        piece = animationPieces.pieces[i];
        
        [rootView addSubview:piece];

        piece.frame = gamePiece.frame;
        
        piece.hidden = NO;
        piece.backgroundColor = gamePiece.backgroundColor;
        piece.alpha = gamePiece.alpha;
        
        piece.text = gamePiece.text;
        piece.textColor = gamePiece.textColor;
        piece.font = gamePiece.font;
    }
    
    [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
        for(int i=0; i<[piecesToAnimate count]; i++) {
                
            piece = animationPieces.pieces[i];
            
            frame = piece.frame;
            
            rvec = [self randomVector];

            frame.origin.x = rvec.x; //*rootView.frame.size.height;
            frame.origin.y = rvec.y; //*rootView.frame.size.height;
            
            if(frame.origin.x < 0) rnum = -1.0;
            else rnum = 1.0;
            
            frame.origin.x += 1.0*rnum*rootView.frame.size.width;
            
            if(frame.origin.y < 0) rnum = -1.0;
            else rnum = 1.0;
            
            frame.origin.y += 1.0*rnum*rootView.frame.size.height;
            
            piece.frame = frame;
        }
            
    } completion:^(BOOL finished) {
            
        for(int i=0; i<[piecesToAnimate count]; i++) {
                
            piece = animationPieces.pieces[i];
            [piece removeFromSuperview];
        }
    }];
}

- (int)signum:(int) n {
    
    return (n < 0) ? -1 : (n > 0) ? +1 : 0;
}

- (CGPoint)randomVector {

    CGPoint vec;
    
    int rnum = arc4random() % 11;
    
    vec.x = pow(-1, rnum)*(arc4random() % 100)/100;
    
    rnum = arc4random() % 11;
    vec.y = pow(-1, rnum)*(arc4random() % 100)/100;

    return vec;
}

- (void)resetForNextLevel {

    [animations.textBox2 removeFromSuperview];
    
    [wordBar makePiecesFlash:0.5f :0.0f];
    
    [self performSelector:@selector(setUpWordBarForLevel) withObject:nil afterDelay:0.41f];
    
    floatPiece.hidden = YES;

    bombPiece.frame = baseBombPiece;
    nukePiece.frame = baseNukePiece;
    
    levelLabel.hidden = NO;
    level.hidden = NO;
    
    level.text = [NSString stringWithFormat:@"%d",gamePlay.gameData.level];
}

- (void)setUpWordBarForLevel {
    
    wordBar.wordCategory = [gamePlay getRandomCategoryForLevel:gamePlay.gameData.level];
    [wordBar setUpForLevel:gamePlay.gameData.level];
    
    [self updateLevelValues];
}

- (void)resetAnimatedPieces {
    
    NSArray *pieces = [[NSArray alloc] initWithArray:piecesToAnimate];
    
    UILabel *savedPiece, *iPiece;

    for(uint i=0; i<[pieces count]; i++) {
        
        savedPiece = [animationPieces.pieces objectAtIndex:i];
        iPiece = [pieces objectAtIndex:i];
        
        iPiece.frame = savedPiece.frame;
        iPiece.backgroundColor = savedPiece.backgroundColor;
        iPiece.alpha = savedPiece.alpha;
    }
}

- (void)hideFloatScore {

    [self updateScore];
    
    floatScore.hidden = YES;
}

- (void)animateScore:(int)addedPoints {
    
    uint rnd = arc4random() % [piecesToAnimate count];
    
    UILabel *piece = [piecesToAnimate objectAtIndex:rnd];
    
    CGRect frm = piece.frame;
    
    frm.size.width = floatScore.frame.size.width;
    frm.size.height = floatScore.frame.size.height;
    
    [floatScore setFrame:frm];
    floatScore.hidden = NO;
    
    if(addedPoints < 0) {
        
        floatScore.textColor = [UIColor colorWithRed:colors.redFlashColor.red green:colors.redFlashColor.green blue:colors.redFlashColor.blue alpha:1.0f];
        
        floatScore.text = [NSString stringWithFormat:@"%d",addedPoints];
    }
    
    else {
        
        floatScore.textColor = [UIColor whiteColor];
        floatScore.text = [NSString stringWithFormat:@"+ %d",addedPoints];
    }
    
    frm = score.frame;
    frm.origin.y = scoreBox.frame.origin.y + scoreBox.frame.size.height - 0.25*frm.size.height;
    frm.origin.x = scoreBox.frame.origin.x - 0.25*frm.size.width;
    
    [UIView animateWithDuration:0.75f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        floatScore.frame = frm;
        
    } completion:^(BOOL finished) {
        
        floatScore.hidden = YES;
        [self updateScore];
    }];
}

- (void)animateLevelTile:(CGFloat)duration {
    
    CGRect lbpFrm = levelBackgroundPiece.frame;
    
    level.hidden = YES;
    
    lbpFrm = baseLevelBackPiece;
    
    lbpFrm.origin.x = (rootView.frame.size.width - lbpFrm.size.width)/2.0;
    lbpFrm.origin.y = 0.5*rootView.frame.size.height;
    
    [levelBackgroundPiece setFrame:lbpFrm];
    
    levelBackgroundPiece.text = [NSString stringWithFormat:@"%d", gamePlay.gameData.level+1];
    
    lbpFrm = baseLevelBackPiece;
    [rootView bringSubviewToFront:levelBackgroundPiece];

    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        levelBackgroundPiece.frame = lbpFrm;
        
    } completion:^(BOOL finished) {
        
        levelBackgroundPiece.text = @"";
        [rootView bringSubviewToFront:levelLabel];
        [rootView bringSubviewToFront:level];
        
    }];
}

- (void)animatePiecesToBottomRow:(CGFloat)duration :(BOOL)fromTop {
    
    UILabel *iPiece;

    __block UILabel *movePiece;
    
    CGRect startFrm[[piecesToAnimate count]];
    
    for(uint i=0; i<[piecesToAnimate count]; i++) {
        
        movePiece = [animationPieces.pieces objectAtIndex:i];
       
        iPiece = [piecesToAnimate objectAtIndex:i];
        iPiece.hidden = YES;
        
        startFrm[i] = iPiece.frame;
        
        if(fromTop) {
            
            startFrm[i].origin.y = topBar.frame.origin.y;
            movePiece.alpha = 0.0;
        }
        else {
            
            startFrm[i].origin.y += iPiece.frame.size.height;
            movePiece.alpha = 0.2f;
        }
        
        movePiece.frame = startFrm[i];
         
        movePiece.backgroundColor = iPiece.backgroundColor;
        movePiece.alpha = iPiece.alpha;
         
        movePiece.text = iPiece.text;
        movePiece.textColor = iPiece.textColor;
        movePiece.font = iPiece.font;
         
        movePiece.hidden = NO;
         
        movePiece.alpha = 0.2f;
         
        [rootView addSubview:movePiece];
    }
     
    [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
     
        for(uint i=0; i<[piecesToAnimate count]; i++) {
     
            movePiece = animationPieces.pieces[i];
            movePiece.frame = ((UILabel*)piecesToAnimate[i]).frame;
            movePiece.alpha = 1.0;
        }
     
     
     } completion:^(BOOL finished) {
     
         for(uint i=0; i<[piecesToAnimate count]; i++) {
     
             movePiece = animationPieces.pieces[i];
             movePiece.hidden = YES;
             [movePiece removeFromSuperview];
             movePiece.text = @"";
             
             ((UILabel*)piecesToAnimate[i]).hidden = NO;
         }
     
    }];
}

- (void)initDisplay:(CGRect)viewFrame : (UIViewController*)rootViewCont {
    
    CGRect frm;
    
    rootView = rootViewCont.view;
    
    piecesToAnimate = [[NSMutableArray alloc] initWithCapacity:500];
    
    animationPieces = [[AnimationPieces alloc] init];
    [animationPieces setUpPieces];
    
    colors = [[Colors alloc] init];
    [colors setUpColors];
    
    frm = viewFrame;
    frm.size.height *= 0.1325;
    
    topBar = [[UIView alloc] initWithFrame:frm];
    
    topOffset = topBar.frame;
    topOffset.size.height += topBar.frame.size.height*WORD_BAR_FACT;
    
    [rootView addSubview:topBar];
    
    wordBar = [[WordBar alloc] init];
    
    frm = topBar.frame;
    frm.size.height *= 1.225;
    frm.origin.y = viewFrame.size.height - frm.size.height;//topBar.frame.size.height;

    bottomBar = [[UIView alloc] initWithFrame:frm];
    
    [rootView addSubview:bottomBar];
    
    frm.size.height = viewFrame.size.height - topOffset.size.height - bottomBar.frame.size.height;
    frm.origin.y = topOffset.size.height;

    boardView = [[UIView alloc] initWithFrame:frm];
    
    [rootView addSubview:boardView];
    
    frm.size.height = 0.7*rootViewCont.view.frame.size.height;
    frm.origin.y = rootViewCont.view.frame.size.height - frm.size.height;
    
    menuView = [[MenuView alloc] initWithFrame:frm];
    
    [menuView setUpView];
    
    [rootView addSubview:menuView];
    [rootView bringSubviewToFront:menuView];
    
    frm = boardView.frame;
    frm.origin.x = topBar.frame.size.height + topOffset.size.height;
    frm.size.height = rootView.frame.size.height - topBar.frame.size.height - topOffset.size.height - bottomBar.frame.size.height;
    
    alertView = [[UIView alloc] initWithFrame:boardView.frame];
    
    alertView.backgroundColor = [UIColor colorWithRed:0.6 green:0.2 blue:0.2 alpha:0.75];
    
    [rootView addSubview:alertView];
    
    topBar.hidden = NO;
    bottomBar.hidden = NO;
    boardView.hidden = NO;
    
    menuView.hidden = YES;
    alertView.hidden = YES;
    
    frm.size.height = 0.70*topBar.frame.size.height;
    frm.origin.y = topBar.frame.origin.y + (topBar.frame.size.height - frm.size.height)/2.0;
    frm.size.width = 0.3333*(topBar.frame.size.width - 2.0*frm.origin.y);
    frm.origin.x = frm.origin.y;
    
    scoreBox = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:scoreBox];
    
    frm.origin.x += frm.size.width + 1.5*frm.origin.y;
    frm.size.width = frm.size.width - 3.0*frm.origin.y;
    
    levelBox = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:levelBox];
    
    frm.origin.x += frm.size.width + 1.5*frm.origin.y;
    frm.size.width = scoreBox.frame.size.width;
    
    nextBox = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:nextBox];
    
    frm = scoreBox.frame;
    frm.size.height *= 0.80;
    frm.origin.y = frm.origin.y + 1.25*(scoreBox.frame.size.height - frm.size.height);///2.0;
    
    score = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:score];
    
    frm = score.frame;
    frm.origin.x = nextBox.frame.origin.x;
    
    nextScore = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:nextScore];
    
    frm = score.frame;
    frm.origin.y = topBar.frame.origin.y + 0.05*frm.size.height;
    
    scoreLabel = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:scoreLabel];
    
    frm = levelBox.frame;
    frm.origin.y = scoreLabel.frame.origin.y + 0.075*scoreLabel.frame.size.height;
    frm.size.height = scoreLabel.frame.size.height;
    
    levelLabel = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:levelLabel];
    
    frm = levelBox.frame;
    frm.size.height *= 0.8;
    frm.origin.y = levelLabel.frame.origin.y + 0.45*levelLabel.frame.size.height;
    
    level = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:level];
    
    frm = levelBox.frame;
    frm.size.width *= 0.85;
    frm.size.height *= 0.825;
    frm.origin.x = frm.origin.x + (levelBox.frame.size.width - frm.size.width)/2.0;
    frm.origin.y = frm.origin.y + (levelBox.frame.size.height - frm.size.height)/2.0 + 0.01*frm.size.height;
    
    levelBackgroundPiece = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:levelBackgroundPiece];
    
    frm = scoreLabel.frame;
    frm.origin.x = nextBox.frame.origin.x;
    
    nextScoreLabel = [[UILabel alloc] initWithFrame:frm];
    [rootView addSubview:nextScoreLabel];
    
    baseLevel = level.frame;
    baseLevelBackPiece = levelBackgroundPiece.frame;
    baseLevelLabel = levelLabel.frame;
    
    [rootView bringSubviewToFront:levelLabel];
    [rootView bringSubviewToFront:level];
    
    [self setUpColors] ;
    
    CGRect tmpFrm;
    
    tmpFrm = scoreBox.frame;
    scoreBox.frame = nextBox.frame;
    nextBox.frame = tmpFrm;
    
    tmpFrm = scoreLabel.frame;
    scoreLabel.frame = nextScoreLabel.frame;
    nextScoreLabel.frame = tmpFrm;
    
    tmpFrm = score.frame;
    score.frame = nextScore.frame;
    nextScore.frame = tmpFrm;
}

- (void)setUpColors {
    
    topBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
    bottomBar.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.4];
    boardView.backgroundColor = [UIColor clearColor];
 
    topBar.layer.borderColor = [[UIColor clearColor] CGColor];
    
    [wordBar setUp:NUM_WORDBAR_LETTERS :topBar.frame :scoreBox.frame.origin.x :rootView];
    wordBar.barBackground.backgroundColor = [UIColor clearColor];//topBar.backgroundColor;
    
    menuView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.5];
    
    UIGraphicsBeginImageContext(rootView.frame.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"stars1.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, rootView.frame.size.width, rootView.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    rootView.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
 // Boxes
    
    scoreBox.hidden = NO;
    scoreBox.layer.cornerRadius = 5.0;
    scoreBox.clipsToBounds = YES;
    scoreBox.opaque = NO;
    scoreBox.layer.borderWidth = 0.75f;
    
    [scoreBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    scoreBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    levelBox.hidden = NO;
    levelBox.layer.cornerRadius = 5.0;
    levelBox.clipsToBounds = YES;
    levelBox.opaque = NO;
    levelBox.layer.borderWidth = 0.75f;
    
    [levelBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    nextBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    nextBox.hidden = NO;
    nextBox.layer.cornerRadius = 5.0;
    nextBox.clipsToBounds = YES;
    nextBox.opaque = NO;
    nextBox.layer.borderWidth = 0.75f;
    
    [nextBox.layer setBorderColor:[[UIColor clearColor] CGColor]];
    levelBox.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.15];
    
    
    // Value labels
    
    score.hidden = NO;
    score.layer.cornerRadius = 5.0;
    score.clipsToBounds = YES;
    score.opaque = NO;
    
    [score setTextAlignment:NSTextAlignmentCenter];
    [score setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.1*FONT_FACT*score.frame.size.height]];
    
    score.textColor = [UIColor colorWithRed:colors.scoreColor.red green:colors.scoreColor.green blue:colors.scoreColor.blue alpha:1.0f];
    score.backgroundColor = [UIColor clearColor];
    
    level.hidden = NO;
    level.layer.cornerRadius = 5.0;
    level.clipsToBounds = YES;
    level.opaque = NO;
    
    [level setTextAlignment:NSTextAlignmentCenter];
    [level setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.2*FONT_FACT*score.frame.size.height]];
    
    level.textColor = [UIColor colorWithRed:colors.levelColor.red green:colors.levelColor.green blue:colors.levelColor.blue alpha:0.8f];
    
    level.backgroundColor = [UIColor clearColor];
    
    nextScore.hidden = NO;
    nextScore.layer.cornerRadius = 5.0;
    nextScore.clipsToBounds = YES;
    nextScore.opaque = NO;
    
    [nextScore setTextAlignment:NSTextAlignmentCenter];
    [nextScore setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.2*FONT_FACT*score.frame.size.height]];
    
    nextScore.textColor = score.textColor; //[UIColor colorWithRed:colors.bottomBarBackgroundColor.red green:colors.bottomBarBackgroundColor.green blue:colors.bottomBarBackgroundColor.blue alpha:1.0f];
    
    nextScore.backgroundColor = [UIColor clearColor];
    
    scoreLabel.hidden = NO;
    scoreLabel.layer.cornerRadius = 5.0;
    scoreLabel.clipsToBounds = YES;
    scoreLabel.opaque = NO;
    
    [scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreLabel setFont:[UIFont fontWithName:@"Helvetica" size:0.75*FONT_FACT*score.frame.size.height]];
    
    scoreLabel.textColor = [UIColor whiteColor];
    scoreLabel.backgroundColor = [UIColor clearColor];
    
    scoreLabel.text = @"Score";
    
    
 // Level Background label
    
    UIGraphicsBeginImageContext(levelBackgroundPiece.frame.size);
    
    tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, levelBackgroundPiece.frame.size.width, levelBackgroundPiece.frame.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    levelBackgroundPiece.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    levelBackgroundPiece.hidden = NO;
    levelBackgroundPiece.layer.cornerRadius = 5.0;
    levelBackgroundPiece.clipsToBounds = YES;
    levelBackgroundPiece.opaque = NO;
    
    [levelBackgroundPiece setTextAlignment:NSTextAlignmentCenter];
    [levelBackgroundPiece setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.2*FONT_FACT*score.frame.size.height]];
    
    levelBackgroundPiece.text = @"";
    levelBackgroundPiece.textColor = [UIColor colorWithRed:colors.levelColor.red green:colors.levelColor.green blue:colors.levelColor.blue alpha:1.0f];

    
 // Level Label
    
    levelLabel.hidden = NO;
    levelLabel.layer.cornerRadius = 5.0;
    levelLabel.clipsToBounds = YES;
    levelLabel.opaque = NO;
    
    [levelLabel setTextAlignment:NSTextAlignmentCenter];
    [levelLabel setFont:[UIFont fontWithName:@"Helvetica" size:0.75*FONT_FACT*score.frame.size.height]];
    
    levelLabel.textColor = [UIColor whiteColor];
    levelLabel.backgroundColor = [UIColor clearColor];
    
    levelLabel.text = @"Level";

    
    // Next level label
    
    nextScoreLabel.hidden = NO;
    nextScoreLabel.layer.cornerRadius = 5.0;
    nextScoreLabel.clipsToBounds = YES;
    nextScoreLabel.opaque = NO;
    
    [nextScoreLabel setTextAlignment:NSTextAlignmentCenter];
    [nextScoreLabel setFont:[UIFont fontWithName:@"Helvetica" size:0.75*FONT_FACT*score.frame.size.height]];
    
    nextScoreLabel.textColor = [UIColor whiteColor];
    nextScoreLabel.backgroundColor = [UIColor clearColor];
    
    nextScoreLabel.text = @"Word Type";
}

- (CGRect)initBoardView: (CGRect)viewFrame{
    
    CGRect boardFrm;
    
    CGFloat aRatio = rootView.frame.size.width/rootView.frame.size.height;
    
    boardFrm.origin.x = 0.03*viewFrame.size.width;
    
    if(aRatio > 0.74)
        boardFrm.origin.x *= 2.5;
    
    boardFrm.origin.y = boardView.frame.origin.y + boardFrm.origin.x;// 0.03*viewFrame.size.width;
    boardFrm.size.height = boardView.frame.size.height;// - 0.5*boardFrm.origin.x;
    boardFrm.size.width = viewFrame.size.width - 2.0*boardFrm.origin.x;
    
    return boardFrm;
}

- (void)setUpFloatPieces:(CGRect)pcFrm {
    
    UIGraphicsBeginImageContext(pcFrm.size);
    
    UIImage *tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();
    
    floatPiece = [[UILabel alloc] initWithFrame:pcFrm];
    floatPiece.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];//[UIColor lightGrayColor];
    
    floatPiece.layer.cornerRadius = 10.0f;
    floatPiece.clipsToBounds = YES;
    floatPiece.hidden = YES;
    
    [floatPiece setTextAlignment:NSTextAlignmentCenter];
    [floatPiece setFont:[UIFont fontWithName:@"Arial" size:1.0*FONT_FACT*pcFrm.size.width]];
    floatPiece.textColor = [UIColor whiteColor];
    
    [rootView addSubview:floatPiece];
    
    floatPieceOffSet.width = pcFrm.size.width/2.0;
    floatPieceOffSet.height = pcFrm.size.height/2.0;
    
    pcFrm.size.width *= 1.05;
    pcFrm.size.height *= 1.05;
    pcFrm.origin.x = 0.75*bottomBar.frame.size.width;
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0;
    
    baseAddPiece = pcFrm;
    
    UIGraphicsBeginImageContext(pcFrm.size);
    tmpImage = [UIImage imageNamed:@"redSquare.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    
    floatBackImage = UIGraphicsGetImageFromCurrentImageContext();
    
    addPiece = [[UILabel alloc] initWithFrame:pcFrm];
    addPiece.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.4];
    
    addPiece.layer.cornerRadius = 10.0f;
    addPiece.clipsToBounds = YES;
    addPiece.hidden = NO;
    
    [addPiece setTextAlignment:NSTextAlignmentCenter];
    [addPiece setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.5*FONT_FACT*pcFrm.size.width]];
    addPiece.textColor = [UIColor colorWithRed:0.7 green:0.3 blue:0.3 alpha:0.7];
 
    addPiece.text = @"";
    
  //  [rootView addSubview:addPiece];
    
    addPieceOffSet.width = pcFrm.size.width/2.0;
    addPieceOffSet.height = pcFrm.size.height/2.0;
    
    pcFrm.size.width *= 0.80;
    pcFrm.size.height = 0.80*pcFrm.size.width;
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0;
    pcFrm.origin.x = bottomBar.frame.size.width - addPiece.frame.size.width - addPiece.frame.origin.x;
    
    UIGraphicsBeginImageContext(pcFrm.size);
    
    tmpImage = [UIImage imageNamed:@"menuBars.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    menuBar = [[UIImageView alloc] initWithImage:tmpImage];
    
    [menuBar setFrame:pcFrm];
    
    [rootView addSubview:menuBar];
    
 // Miscellaneous pieces:
    
 // Bomb piece
    
    pcFrm = addPiece.frame;
    pcFrm.size.height *=1.15;
    pcFrm.size.width = 0.75*pcFrm.size.height;
    pcFrm.origin.y -= 0.15*pcFrm.size.width;
    pcFrm.origin.x -= 1.5*(bottomBar.frame.size.width - (addPiece.frame.origin.x + addPiece.frame.size.width));
    
    bombPiece = [[UILabel alloc] initWithFrame:pcFrm];
    
    UIGraphicsBeginImageContext(pcFrm.size);
    
    tmpImage = [UIImage imageNamed:@"bomb.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    bombPiece.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    [rootView addSubview:bombPiece];
    
    bombPiece.layer.cornerRadius = 10.0f;
    bombPiece.clipsToBounds = YES;
    bombPiece.opaque = YES;

    bombPiece.hidden = YES;
    baseBombPiece = bombPiece.frame;
    
 // Num bombs label
    
    pcFrm = bombPiece.frame;
    pcFrm.origin.y += 0.135*pcFrm.size.height;
    
    numBombsLabel = [[UILabel alloc] initWithFrame:pcFrm];
    [rootView addSubview:numBombsLabel];
    
    numBombsLabel.layer.cornerRadius = 10.0f;
    numBombsLabel.clipsToBounds = YES;
    numBombsLabel.opaque = YES;
    
    [numBombsLabel setTextAlignment:NSTextAlignmentCenter];
    [numBombsLabel setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:0.8*FONT_FACT*pcFrm.size.width]];
    numBombsLabel.textColor = [UIColor colorWithRed:0.8 green:0.3 blue:0.3 alpha:0.7];
    numBombsLabel.text = @"";
    
    numBombsLabel.hidden = YES;

 // Nuke piece
    
    pcFrm = bombPiece.frame;
    pcFrm.size.width *= 1.2;
    pcFrm.size.height = pcFrm.size.width;
    pcFrm.origin.x -= pcFrm.size.width + addPiece.frame.origin.x - (bombPiece.frame.origin.x + bombPiece.frame.size.width);
    
    pcFrm.origin.y = bottomBar.frame.origin.y + (bottomBar.frame.size.height - pcFrm.size.height)/2.0 - 0.05*pcFrm.size.height;
    nukePiece = [[UILabel alloc] initWithFrame:pcFrm];
    
    UIGraphicsBeginImageContext(pcFrm.size);
    
    tmpImage = [UIImage imageNamed:@"nuke2.png"];
    [tmpImage drawInRect:CGRectMake(0, 0, pcFrm.size.width, pcFrm.size.height)];
    tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    
    nukePiece.backgroundColor = [UIColor colorWithPatternImage:tmpImage];
    
    [rootView addSubview:nukePiece];
    
    nukePiece.layer.cornerRadius = 5.0f;
    nukePiece.clipsToBounds = YES;
    nukePiece.opaque = YES;
    
    nukePiece.hidden = YES;
    baseNukePiece = nukePiece.frame;
    
 // Num nukes label
    
    pcFrm = nukePiece.frame;
    pcFrm.origin.y += 0.135*pcFrm.size.height;
    
    
    numNukesLabel = [[UILabel alloc] initWithFrame:pcFrm];
  //  [rootView addSubview:numNukesLabel];
    
    numNukesLabel.layer.cornerRadius = numBombsLabel.layer.cornerRadius;
    numNukesLabel.clipsToBounds = numBombsLabel.clipsToBounds;
    numNukesLabel.opaque = numBombsLabel.opaque;
    
    [numNukesLabel setTextAlignment:NSTextAlignmentCenter];
    numNukesLabel.font = numBombsLabel.font;
    numNukesLabel.textColor = numBombsLabel.textColor;
    numNukesLabel.text = @"";
    
    numNukesLabel.hidden = YES;

 // Float score label
    
    pcFrm = addPiece.frame;
    pcFrm.size.width *= 2.0;
    pcFrm.size.height *= 1.5;
    
    floatScore = [[UILabel alloc] initWithFrame: pcFrm];
    
    [rootView addSubview:floatScore];
    
    floatScore.layer.cornerRadius = 5.0;
    floatScore.clipsToBounds = YES;
    floatScore.opaque = NO;
    
    [floatScore setTextAlignment:NSTextAlignmentCenter];
    [floatScore setFont:[UIFont fontWithName:@"MarkerFelt-Thin" size:1.25*FONT_FACT*floatScore.frame.size.height]];
    
    floatScore.textColor = [UIColor whiteColor];
    floatScore.backgroundColor = [UIColor clearColor];
    
    [self setUpAnimations];
    
    [rootView sendSubviewToBack:alertView];
}

- (void)addLabelToSuperView:(UILabel*)label {

    [rootView addSubview:label];
}

- (void)setUpAnimations {
    
    animations = [[Animations alloc] init];
    [animations setUp:rootView.frame :topBar.frame.size.height/2.5 :rootView];
}

- (void)deconstruct {

    [topBar removeFromSuperview];
    [floatPiece removeFromSuperview];
    [bottomBar removeFromSuperview];
    [menuView removeFromSuperview];
    [addPiece removeFromSuperview];
    [alertView removeFromSuperview];
    
    [score removeFromSuperview];
    [level removeFromSuperview];
    [nextScore removeFromSuperview];
    
    [scoreBox removeFromSuperview];
    [levelBox removeFromSuperview];
    [nextScore removeFromSuperview];
    
    [scoreLabel removeFromSuperview];
    [levelLabel removeFromSuperview];
    [nextScoreLabel removeFromSuperview];
    [levelBackgroundPiece removeFromSuperview];
    
    [floatScore removeFromSuperview];
    [bombPiece removeFromSuperview];
    [nukePiece removeFromSuperview];
    
    [numBombsLabel removeFromSuperview];
    [numNukesLabel removeFromSuperview];
    
    [piecesToAnimate removeAllObjects];
    
    topBar = nil;
    floatPiece = nil;
    bottomBar = nil;
    menuView = nil;
    addPiece = nil;
    
    alertView = nil;
    
    score = nil;
    level = nil;
    nextScore = nil;
    
    scoreBox = nil;
    levelBox = nil;
    nextBox = nil;
    
    scoreLabel = nil;
    levelLabel = nil;
    nextScoreLabel = nil;
    levelBackgroundPiece = nil;
    
    floatScore = nil;
    bombPiece = nil;
    nukePiece = nil;
    
    numBombsLabel = nil;
    numNukesLabel = nil;
    
    colors = nil;
    
    piecesToAnimate = nil;
    
    [animationPieces deconstruct];
    animationPieces = nil;
    
    [animations deconstruct];
    animations = nil;
    
    [wordBar deconstruct];
    wordBar = nil;
}

@end
