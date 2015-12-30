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
    UILabel *nextScoreLabel;
    
    UILabel *floatScore;
    UILabel *bombPiece;
    UILabel *bonusLabel1;
    UILabel *bonusLabel2;
    
    UIImage *floatBackImage;
    
    UIImageView *menuBar;
    
    CGSize floatPieceOffSet;
    CGSize addPieceOffSet;
    
    CGRect baseAddPiece;
    CGRect baseBombPiece;
    
    GamePlay *gamePlay;
    
    NSMutableArray *piecesToAnimate;
    
    AnimationPieces *animationPieces;
    
    Colors *colors;
}

@property(nonatomic, strong) UIView *topBar;
@property(nonatomic, strong) UIView *boardView;
@property(nonatomic, strong) UIView *bottomBar;

@property(nonatomic, strong) MenuView *menuView;
@property(nonatomic, strong) GamePlay *gamePlay;

@property(nonatomic, strong) UILabel *floatPiece;
@property(nonatomic, strong) UILabel *addPiece;
@property(nonatomic, strong) UILabel *bombPiece;

@property(nonatomic, strong) UIImageView *menuBar;

@property(nonatomic, strong) NSMutableArray *piecesToAnimate;

- (void)initDisplay:(CGRect)viewFrame :(UIViewController*)rootViewCont;
- (void)setUpColors;
- (void)setUpFloatPieces:(CGRect)pcFrm;

- (void)changeFloatPieceLoc:(CGPoint)newLoc;
- (void)configureFloatPiece:(Space*)space;

- (void)changeAddPieceLoc:(CGPoint)newLoc;
- (void)changeBombPieceLoc:(CGPoint)newLoc;

- (void)resetAddPiece;
- (void)resetBombPiece;

- (void)deconstruct;
- (void)updateScore;
- (void)hideAlertView;
- (void)updateLevelValues;

- (void)makePiecesFlash:(BOOL)wrongWord;
- (void)resetAnimatedPieces;
- (void)animateAlertView;

- (void)animateScore:(int)addedPoints;

- (CGRect)initBoardView:(CGRect)viewFrame;

@end
