//
//  Display.h
//  Droozle
//
//  Created by Jason Deckman on 9/21/15.
//  Copyright (c) 2015 JDeckman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Colors.h"
#import "Space.h"
#import "MenuView.h"
#import "GamePlay.h"
#import "AnimationPieces.h"
#import "Animations.h"
#import "WordBar.h"

#define NUM_WORDBAR_LETTERS 9

@interface Display : NSObject {
    
    UIView *topBar;
    UIView *bottomBar;
    UIView *boardView;
    UIView *rootView;
    UIView *alertView;
    
    MenuView *menuView;
    
    UILabel *floatPiece;
    UILabel *addPiece;
    
    UILabel *scoreBox;
    UILabel *levelBox;
    UILabel *nextBox;
    
    UILabel *score;
    UILabel *level;
    UILabel *nextScore;
    
    UILabel *scoreLabel;
    UILabel *levelLabel;
    UILabel *levelBackgroundPiece;
    UILabel *nextScoreLabel;
    
    UILabel *floatScore;
    UILabel *bombPiece;
    UILabel *nukePiece;
    
    UILabel *numBombsLabel;
    UILabel *numNukesLabel;
    
    UIImage *floatBackImage;
    
    UIImageView *menuBar;
    
    CGSize floatPieceOffSet;
    CGSize addPieceOffSet;
    
    CGRect baseAddPiece;
    CGRect baseBombPiece;
    CGRect baseNukePiece;
    
    CGRect baseLevelBackPiece;
    CGRect baseLevelLabel;
    CGRect baseLevel;
    
    
    CGRect topOffset;
    
    GamePlay *gamePlay;
    
    NSMutableArray *piecesToAnimate;
    
    AnimationPieces *animationPieces;
    Animations *animations;
    
    WordBar *wordBar;
    
    Colors *colors;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIView *boardView;
@property(nonatomic, strong) UIView *bottomBar;

@property(nonatomic) CGRect topOffset;

@property(nonatomic, strong) MenuView *menuView;
@property(nonatomic, strong) GamePlay *gamePlay;

@property(nonatomic, strong) UILabel *floatPiece;
@property(nonatomic, strong) UILabel *addPiece;
@property(nonatomic, strong) UILabel *bombPiece;
@property(nonatomic, strong) UILabel *nukePiece;
@property(nonatomic, strong) UILabel *levelLabel;
@property(nonatomic, strong) UILabel *level;

@property(nonatomic, strong) UIImageView *menuBar;

@property(nonatomic, strong) NSMutableArray *piecesToAnimate;

@property(nonatomic, strong) Animations *animations;
@property(nonatomic, strong) WordBar *wordBar;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;
- (void)setUpFloatPieces:(CGRect)pcFrm;
- (void)resetForNextLevel;

- (void)changeFloatPieceLoc:(CGPoint)newLoc;
- (void)configureFloatPiece:(Space*)space;

- (void)changeAddPieceLoc:(CGPoint)newLoc;
- (void)changeBombPieceLoc:(CGPoint)newLoc;
- (void)changeNukePieceLoc:(CGPoint)newLoc;

- (void)resetAddPiece;
- (void)resetBombPiece:(BOOL)bombUsed;
- (void)resetNukePiece:(BOOL)nukeUsed;

- (void)deconstruct;
- (void)updateScore;
- (void)hideAlertView;
- (void)updateLevelValues;

- (void)makePiecesFlash:(BOOL)wrongWord :(CGFloat)delay;
- (void)makePiecesFlashExt:(BOOL)wrongWord :(CGFloat)duration :(NSMutableArray*)animPieces;
- (void)makePiecesExplode:(CGFloat)duration :(CGFloat)delay;

- (void)resetAnimatedPieces;
- (void)animateAlertView;
- (void)unhideAlertViewWithAlpha:(CGFloat)alpha;
- (void)checkAlertView:(uint)nrows;

- (void)animateScore:(int)addedPoints;
- (void)animateLevelTile:(CGFloat)duration;
- (void)animatePiecesToBottomRow:(CGFloat)duration :(BOOL)fromTop;

- (CGRect)initBoardView:(CGRect)viewFrame;

- (void)addLabelToSuperView:(UILabel*)label;

@end
